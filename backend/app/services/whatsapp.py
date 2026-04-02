import httpx
import asyncio
import random
import re
from typing import Optional, List
from app.core import config # Assumindo que teremos um config.py

# Evolution API Config (Valores exemplo, devem vir do .env)
EVOLUTION_API_URL = "http://evolution:8080"
EVOLUTION_API_KEY = "my_secure_api_key"

class WhatsAppService:
    def __init__(self):
        self.client = httpx.AsyncClient(
            base_url=EVOLUTION_API_URL,
            headers={"apikey": EVOLUTION_API_KEY}
        )

    async def send_text_message(self, instance: String, number: str, text: str):
        """
        Envia uma mensagem de texto via Evolution API com delay humano simulado.
        """
        # 1. Delay Aleatório entre mensagens (800-2500ms)
        delay = random.uniform(0.8, 2.5)
        await asyncio.sleep(delay)

        # 2. Variação leve na mensagem (Opcional: adicionar variações de cordialidade)
        # text = self._apply_human_variation(text)

        payload = {
            "number": number,
            "options": {
                "delay": 1200, # Delay interno da Evolution API
                "presence": "composing", # Simulando que está digitando
                "linkPreview": False
            },
            "textMessage": {
               "text": text
            }
        }

        try:
            response = await self.client.post(
                f"/message/sendText/{instance}",
                json=payload
            )
            response.raise_for_status()
            return response.json()
        except Exception as e:
            print(f"Erro ao enviar mensagem para {number}: {e}")
            return None

    def extract_price_from_text(self, text: str) -> Optional[float]:
        """
        Extrai o preço de uma mensagem recebida usando Regex robusto.
        Padrões: R$ 10,00, 10.00, 10,00, etc.
        """
        # Padrão mais flexível: ignora R$, aceita , ou . como separador decimal. 
        # Ignora pontos de milhar se seguidos por 3 dígitos e vírgula.
        text = text.replace(' ', '')
        price_pattern = r"(?:R\$|r\$|\$)?(\d{1,3}(?:\.\d{3})*|\d+)(?:,(\d{2}))?"
        match = re.search(price_pattern, text)

        if not match:
            return None

        try:
            integers = match.group(1).replace('.', '')
            decimals = match.group(2) or "00"
            return float(f"{integers}.{decimals}")
        except ValueError:
            return None

    def extract_payment_term_days(self, text: str) -> Optional[int]:
        """
        Extrai o prazo de pagamento em dias.
        Ex: "30 dias", "em 60 dias", "prazo 15 d", "à vista" (0)
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
        """
        Extrai a forma de pagamento (boleto, pix, cartão, etc).
        """
        text_lower = text.lower()
        conditions = {
            "boleto": ["boleto", "blto"],
            "pix": ["pix", "transferência", "ted", "doc"],
            "cartão": ["cartão", "credito", "debito", "visa", "master"],
            "dinheiro": ["dinheiro", "cash"],
            "depósito": ["depósito", "deposito"]
        }
        
        for condition, keywords in conditions.items():
            if any(kw in text_lower for kw in keywords):
                return condition.capitalize()
        
        return None

    def extract_lead_time(self, text: str) -> Optional[int]:
        """
        Extrai o prazo de entrega (lead time) em dias.
        Ex: "entrega em 3 dias", "chega em 2 d", "imediato" (0)
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
        """
        Extrai o tipo de frete (CIF ou FOB).
        """
        text_upper = text.upper()
        if "CIF" in text_upper or "FRETE INCLUSO" in text_upper or "FRETE GRÁTIS" in text_upper:
            return "CIF"
        if "FOB" in text_upper or "COLETAR" in text_upper or "SEM FRETE" in text_upper:
            return "FOB"
        return None

    def extract_installments(self, text: str) -> Optional[str]:
        """
        Extrai condições de parcelamento (ex: 30/60/90, 3x, 1+2).
        """
        text_lower = text.lower()
        # Padrão para datas separadas por barra: 15/30/45
        date_pattern = r"(\d{1,3}(?:/\d{1,3})+)"
        match_dates = re.search(date_pattern, text_lower)
        if match_dates:
            return match_dates.group(1)
            
        # Padrão para X vezes: 3x, 3 vezes
        times_pattern = r"(\d+)\s*(?:x|vezes)\b"
        match_times = re.search(times_pattern, text_lower)
        if match_times:
            return f"{match_times.group(1)}x"
            
        return None

    def _apply_human_variation(self, text: str) -> str:
        """
        Aplica variações randômicas para evitar padrões robóticos detectáveis por IA do WhatsApp.
        """
        greetings = ["Olá", "Oi", "Tudo bem?", "Bom dia", "Boa tarde"]
        selected_greeting = random.choice(greetings)
        
        # Exemplo simples: Variar saudação se não houver uma explícita no template
        if not text.startswith(('Olá', 'Oi', 'Bom', 'Boa')):
            return f"{selected_greeting}, {text}"
        return text

whatsapp_service = WhatsAppService()
