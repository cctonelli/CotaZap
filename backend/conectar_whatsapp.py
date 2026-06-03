import os
import time
import requests
import base64

API_URL = "http://localhost:8181"
API_KEY = "429683C4C977415CAAFCCE10F7D57E11"
INSTANCE_NAME = "cotazap"

HEADERS = {
    "apikey": API_KEY,
    "Content-Type": "application/json"
}

def save_qr_code(base64_data):
    if not base64_data:
        print("QR Code não encontrado na resposta.")
        return False
        
    if "," in base64_data:
        base64_data = base64_data.split(",")[1]
        
    img_data = base64.b64decode(base64_data)
    file_path = "qrcode.png"
    
    with open(file_path, "wb") as f:
        f.write(img_data)
        
    print(f"\n======================================")
    print(f"✅ SUCESSO! O QR Code foi gerado.")
    print(f"📁 Abra o arquivo '{file_path}' na raiz desta pasta.")
    print(f"📱 Escaneie o código com seu WhatsApp em até 30 segundos!")
    print(f"======================================\n")
    
    # Tenta abrir o arquivo automaticamente no Windows
    os.system(f"start {file_path}")
    return True

def create_and_pair():
    print(f"Tentando criar ou conectar a instância '{INSTANCE_NAME}'...")
    
    # 1. Tenta buscar se a instância já existe
    state_url = f"{API_URL}/instance/connectionState/{INSTANCE_NAME}"
    state_resp = requests.get(state_url, headers=HEADERS)
    
    if state_resp.status_code == 200:
        state_data = state_resp.json()
        status = state_data.get("instance", {}).get("state", "")
        
        if status == "open":
            print("🚀 O WhatsApp já está conectado e pronto! Não é necessário parear novamente.")
            return

    # 2. Requisita o pareamento (seja criação ou nova conexão)
    connect_url = f"{API_URL}/instance/connect/{INSTANCE_NAME}"
    print("Solicitando novo QR Code...")
    conn_resp = requests.get(connect_url, headers=HEADERS)
    
    if conn_resp.status_code in [200, 201]:
        data = conn_resp.json()
        b64 = data.get("base64")
        if b64:
            save_qr_code(b64)
            return
            
    # 3. Se deu erro, tentamos criar a instância do zero
    print("A instância parece não existir ainda. Criando nova...")
    create_url = f"{API_URL}/instance/create"
    payload = {
        "instanceName": INSTANCE_NAME,
        "qrcode": True,
        "integration": "WHATSAPP-BAILEYS"
    }
    
    create_resp = requests.post(create_url, headers=HEADERS, json=payload)
    if create_resp.status_code in [200, 201]:
        data = create_resp.json()
        # O qrcode pode retornar dentro de um objeto "qrcode" dict
        qr_obj = data.get("qrcode", {})
        if isinstance(qr_obj, dict):
            b64 = qr_obj.get("base64")
        else:
            b64 = data.get("base64")
            
        if b64:
            save_qr_code(b64)
        else:
            print("Instância criada, mas o QR Code não veio. Tente rodar o script novamente.")
    else:
        print(f"Erro ao criar instância: {create_resp.status_code}")
        print(create_resp.text)

if __name__ == "__main__":
    create_and_pair()
