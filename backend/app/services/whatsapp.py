import httpx
import asyncio
import random
import re
import os
from typing import Optional, List
from dotenv import load_dotenv

load_dotenv()

# Evolution API Config — lidos do .env
EVOLUTION_API_URL = os.getenv("EVOLUTION_API_URL", "http://localhost:8080")
EVOLUTION_API_KEY = os.getenv("EVOLUTION_API_KEY", "my_secure_api_key")
EVOLUTION_INSTANCE = os.getenv("EVOLUTION_INSTANCE", "cotazap")


class WhatsAppService:
    def __init__(self):
        self.base_url = EVOLUTION_API_URL
        self.api_key = EVOLUTION_API_KEY
        self.instance = EVOLUTION_INSTANCE

    def _build_client(self) -> httpx.AsyncClient:
        """Cria um novo cliente HTTP com as credenciais da Evolution API."""
        return httpx.AsyncClient(
            base_url=self.base_url,
            headers={"apikey": self.api_key},
            timeout=30.0,
        )

    async def send_text_message(self, number: str, text: str, instance: Optional[str] = None) -> Optional[dict]:
        """
        Envia uma mensagem de texto via Evolution API com delay humano simulado.
        Normaliza o número para garantir compatibilidade com o formato WhatsApp.
        """
        # 1. Delay Aleatório entre mensagens (800-2500ms) para simular comportamento humano
        delay = random.uniform(0.8, 2.5)
        await asyncio.sleep(delay)

        # 2. Normalizar número: remover caracteres não numéricos
        clean_number = re.sub(r"\D", "", number)

        # 3. Garantir que tem DDI 55 (Brasil)
        if not clean_number.startswith("55"):
            clean_number = f"55{clean_number}"

        target_instance = instance or self.instance

        payload = {
            "number": clean_number,
            "options": {
                "delay": 1200,           # Delay interno da Evolution API (ms)
                "presence": "composing", # Simula "digitando..."
                "linkPreview": False,
            },
            "textMessage": {
                "text": text,
            },
        }

        try:
            async with self._build_client() as client:
                response = await client.post(
                    f"/message/sendText/{target_instance}",
                    json=payload,
                )
                response.raise_for_status()
                result = response.json()
                print(f"✅ Mensagem enviada para {clean_number}: {result.get('key', {}).get('id', 'sem id')}")
                return result
        except httpx.HTTPStatusError as e:
            print(f"❌ Erro HTTP ao enviar para {clean_number}: {e.response.status_code} — {e.response.text}")
            return None
        except Exception as e:
            print(f"❌ Erro ao enviar mensagem para {clean_number}: {e}")
            return None

    async def send_quotation_to_suppliers(
        self,
        suppliers: List[dict],
        message: str,
        instance: Optional[str] = None,
    ) -> dict:
        """
        Dispara a mensagem de cotação para uma lista de fornecedores.
        Cada item da lista deve ter os campos 'whatsapp' e 'trade_name'.
        Retorna um resumo {enviados, falhos, detalhes}.
        """
        sent = []
        failed = []

        for supplier in suppliers:
            whatsapp = supplier.get("whatsapp", "")
            trade_name = supplier.get("trade_name", "Fornecedor")

            if not whatsapp:
                failed.append({"supplier": trade_name, "reason": "Número WhatsApp não cadastrado"})
                continue

            result = await self.send_text_message(
                number=whatsapp,
                text=message,
                instance=instance,
            )

            if result:
                sent.append({"supplier": trade_name, "whatsapp": whatsapp})
            else:
                failed.append({"supplier": trade_name, "whatsapp": whatsapp, "reason": "Falha no envio"})

        return {
            "total": len(suppliers),
            "sent": len(sent),
            "failed": len(failed),
            "details_sent": sent,
            "details_failed": failed,
        }

    # --------------------------------------------------------------------------
    # Parsers de resposta dos fornecedores
    # --------------------------------------------------------------------------

    def extract_price_from_text(self, text: str) -> Optional[float]:
        """
        Extrai o preço de uma mensagem recebida usando Regex robusto.
        Padrões: R$ 10,00 | 10.00 | 10,00 | etc.
        """
        text = text.replace(" ", "")
        price_pattern = r"(?:R\$|r\$|\$)?(\d{1,3}(?:\.\d{3})*|\d+)(?:,(\d{2}))?"
        match = re.search(price_pattern, text)
        if not match:
            return None
        try:
            integers = match.group(1).replace(".", "")
            decimals = match.group(2) or "00"
            return float(f"{integers}.{decimals}")
        except ValueError:
            return None

    def extract_payment_term_days(self, text: str) -> Optional[int]:
        """
        Extrai o prazo de pagamento em dias.
        Ex: "30 dias", "em 60 dias", "prazo 15 d", "à vista" (0).
        """
        text_lower = text.lower()
        if any(x in text_lower for x in ["à vista", "a vista", "avista", "dinheiro", "pix"]):
            return 0
        term_pattern = r"(\d+)\s*(?:dias|dia|d)\b"
        match = re.search(term_pattern, text_lower)
        if match:
            return int(match.group(1))
        return None

    def extract_payment_condition(self, text: str) -> Optional[str]:
        """Extrai a forma de pagamento (boleto, pix, cartão, etc)."""
        text_lower = text.lower()
        conditions = {
            "boleto": ["boleto", "blto"],
            "pix": ["pix", "transferência", "ted", "doc"],
            "cartão": ["cartão", "credito", "debito", "visa", "master"],
            "dinheiro": ["dinheiro", "cash"],
            "depósito": ["depósito", "deposito"],
        }
        for condition, keywords in conditions.items():
            if any(kw in text_lower for kw in keywords):
                return condition.capitalize()
        return None

    def extract_lead_time(self, text: str) -> Optional[int]:
        """
        Extrai o prazo de entrega (lead time) em dias.
        Ex: "entrega em 3 dias", "chega em 2 d", "imediato" (0).
        """
        text_lower = text.lower()
        if "imediato" in text_lower or "pronta entrega" in text_lower:
            return 0
        pattern = r"(?:entrega|chega|prazo)\s*(?:em|de)?\s*(\d+)\s*(?:dias|dia|d)\b"
        match = re.search(pattern, text_lower)
        if match:
            return int(match.group(1))
        return None

    def extract_freight_info(self, text: str) -> Optional[str]:
        """Extrai o tipo de frete (CIF ou FOB)."""
        text_upper = text.upper()
        if "CIF" in text_upper or "FRETE INCLUSO" in text_upper or "FRETE GRÁTIS" in text_upper:
            return "CIF"
        if "FOB" in text_upper or "COLETAR" in text_upper or "SEM FRETE" in text_upper:
            return "FOB"
        return None

    def extract_installments(self, text: str) -> Optional[str]:
        """Extrai condições de parcelamento (ex: 30/60/90, 3x, 1+2)."""
        text_lower = text.lower()
        date_pattern = r"(\d{1,3}(?:/\d{1,3})+)"
        match_dates = re.search(date_pattern, text_lower)
        if match_dates:
            return match_dates.group(1)
        times_pattern = r"(\d+)\s*(?:x|vezes)\b"
        match_times = re.search(times_pattern, text_lower)
        if match_times:
            return f"{match_times.group(1)}x"
        return None

    def _apply_human_variation(self, text: str) -> str:
        """Aplica variações randômicas para evitar padrões robóticos."""
        greetings = ["Olá", "Oi", "Tudo bem?", "Bom dia", "Boa tarde"]
        selected_greeting = random.choice(greetings)
        if not text.startswith(("Olá", "Oi", "Bom", "Boa")):
            return f"{selected_greeting}, {text}"
        return text


whatsapp_service = WhatsAppService()
