from flask import Flask, request, jsonify
import requests

app = Flask(_name_)

# Configurações da API do eGestor
EGESTOR_API_URL = 'https://aplicacao.egestor.com.br/api'
EGESTOR_API_TOKEN = 'SEU_TOKEN_DE_API'

# Função auxiliar para obter o ID do produto no eGestor
def get_product_id(item):
    produto_sku = item['sku']
    response = requests.get(
        f"{EGESTOR_API_URL}/produtos",
        params={'sku': produto_sku},
        headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
    )
    data = response.json()
    if data.get('produtos'):
        produto_id = data['produtos'][0]['id']
        return produto_id
    else:
        # Opcional: Criar o produto se não existir
        new_product = {
            'nome': item['name'],
            'sku': produto_sku,
            'preco': item['price'],
            'estoque': item['stock'],
            # Outros campos necessários
        }
        response = requests.post(
            f"{EGESTOR_API_URL}/produtos",
            json=new_product,
            headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
        )
        produto_id = response.json().get('id')
        return produto_id

# Função para criar ou atualizar o cliente no eGestor
def create_or_update_customer(customer_info):
    response = requests.get(
        f"{EGESTOR_API_URL}/clientes",
        params={'email': customer_info['email']},
        headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
    )
    data = response.json()
    if data.get('clientes'):
        # Cliente existe, retorna o ID
        customer_id = data['clientes'][0]['id']
        # Opcional: Atualizar o cliente se necessário
        return customer_id
    else:
        # Cliente não existe, criar novo
        new_customer = {
            'nome': customer_info['name'],
            'email': customer_info['email'],
            'telefone': customer_info['phone'],
            'endereco': customer_info['address'],
            # Outros campos necessários
        }
        response = requests.post(
            f"{EGESTOR_API_URL}/clientes",
            json=new_customer,
            headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
        )
        customer_id = response.json().get('id')
        return customer_id

# Função para criar o pedido no eGestor
def create_order(order_data, customer_id):
    order_items = []
    for item in order_data['products']:
        produto_id = get_product_id(item)
        order_items.append({
            'produto_id': produto_id,
            'quantidade': item['quantity'],
            'valor_unitario': item['price']
        })
    new_order = {
        'cliente_id': customer_id,
        'itens': order_items,
        'data': order_data['created_at'],
        # Outros campos necessários
    }
    response = requests.post(
        f"{EGESTOR_API_URL}/pedidos",
        json=new_order,
        headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
    )
    order_id = response.json().get('id')
    return order_id

# Função para atualizar o estoque no eGestor
def update_stock(order_items):
    for item in order_items:
        produto_id = get_product_id(item)
        # Obter o estoque atual
        response = requests.get(
            f"{EGESTOR_API_URL}/produtos/{produto_id}",
            headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
        )
        produto = response.json()
        estoque_atual = produto.get('estoque', 0)
        # Subtrair a quantidade vendida
        novo_estoque = estoque_atual - item['quantity']
        # Atualizar o estoque
        update_data = {'estoque': novo_estoque}
        requests.put(
            f"{EGESTOR_API_URL}/produtos/{produto_id}",
            json=update_data,
            headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
        )

# Função para registrar informações financeiras no eGestor
def register_financials(financial_info, customer_id, order_id):
    new_financial = {
        'cliente_id': customer_id,
        'pedido_id': order_id,
        'valor': financial_info['amount'],
        'data': financial_info['date'],
        'descricao': f"Pagamento referente ao pedido {order_id}",
        # Outros campos necessários
    }
    requests.post(
        f"{EGESTOR_API_URL}/financeiro/receitas",
        json=new_financial,
        headers={'Authorization': f"Bearer {EGESTOR_API_TOKEN}"}
    )

# Função principal para processar o pedido
def process_order(order_data):
    # Extrair informações do pedido
    customer_info = {
        'name': order_data['customer']['name'],
        'email': order_data['customer']['email'],
        'phone': order_data['customer']['phone'],
        'address': order_data['customer']['default_address']['address1'],
        # Outros campos se necessário
    }
    order_items = order_data['products']
    financial_info = {
        'amount': order_data['total_price'],
        'date': order_data['closed_at'] or order_data['created_at'],
    }

    # Passo 1: Criar ou Atualizar Contato no eGestor
    customer_id = create_or_update_customer(customer_info)

    # Passo 2: Criar Pedido no eGestor
    order_id = create_order(order_data, customer_id)

    # Passo 3: Atualizar Estoque no eGestor
    update_stock(order_items)

    # Passo 4: Registrar Informações Financeiras
    register_financials(financial_info, customer_id, order_id)

# Endpoint para receber webhooks da Nuvemshop
@app.route('/webhook/nuvemshop', methods=['POST'])
def nuvemshop_webhook():
    data = request.json
    # Processar os dados recebidos
    try:
        process_order(data)
        return jsonify({'status': 'success'}), 200
    except Exception as e:
        # Logar o erro para análise
        print(f"Erro ao processar o pedido: {e}")
        return jsonify({'status': 'error', 'message': str(e)}), 500

if _name_ == '_main_':
    app.run(debug=True, port=5000)