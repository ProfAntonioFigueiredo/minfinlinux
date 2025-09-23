

-- Slide 11

pwd

mkdir dimdim_bank

cd dimdim_bank



-- Slide 12


ls -l

mkdir clientes transacoes relatorios backup logs

ls -l


-- Slide 13


cd clientes

touch cliente_001_joao_silva.txt cliente_002_maria_santos.txt cliente_003_pedro_oliveira.txt

cd ../transacoes

touch transacoes_janeiro_2025.txt transacoes_fevereiro_2025.txt


echo "João Silva - CPF: 123.456.789-00 - Conta: 12345-6 - Saldo: R$ 1.500,00" > ../clientes/cliente_001_joao_silva.txt 
echo "Maria Santos - CPF: 987.654.321-00 - Conta: 98765-4 - Saldo: R$ 2.800,00" > ../clientes/cliente_002_maria_santos.txt 
echo "Pedro Oliveira - CPF: 456.789.123-00 - Conta: 45678-9 - Saldo: R$ 950,00" > ../clientes/cliente_003_pedro_oliveira.txt

echo "01/01/2025 - Transferência - João Silva -> Maria Santos - R$ 200,00" > transacoes_janeiro_2025.txt 
echo "02/01/2025 - Depósito - Pedro Oliveira - R$ 500,00" >> transacoes_janeiro_2025.txt 
echo "03/01/2025 - Saque - João Silva - R$ 100,00" >> transacoes_janeiro_2025.txt 
echo "15/02/2025 - PIX - Maria Santos -> Pedro Oliveira - R$ 150,00" > transacoes_fevereiro_2025.txt


-- Slide 14


cat transacoes_janeiro_2025.txt

cat ../clientes/cliente_001_joao_silva.txt


cp transacoes_janeiro_2025.txt ../backup/

cp ../clientes/cliente_001_joao_silva.txt ../backup/backup_cliente_001.txt


cd ../relatorios

mv ../transacoes/transacoes_fevereiro_2025.txt relatorio_mensal_fevereiro.txt


-- Slide 15

cd ../transacoes 

echo "05/01/2025 - Pagamento de Conta - João Silva - R$ 80,00" >> transacoes_janeiro_2025.txt 
echo "08/01/2025 - Transferência - Pedro Oliveira -> João Silva - R$ 300,00" >> transacoes_janeiro_2025.txt 
echo "12/01/2025 - Depósito - Maria Santos - R$ 1.200,00" >> transacoes_janeiro_2025.txt 
echo "18/01/2025 - Saque - Pedro Oliveira - R$ 200,00" >> transacoes_janeiro_2025.txt 
echo "22/01/2025 - PIX - João Silva -> Maria Santos - R$ 450,00" >> transacoes_janeiro_2025.txt 
echo "25/01/2025 - Pagamento de Boleto - Maria Santos - R$ 320,00" >> transacoes_janeiro_2025.txt 
echo "28/01/2025 - Transferência - Maria Santos -> Pedro Oliveira - R$ 180,00" >> transacoes_janeiro_2025.txt

tail -10 transacoes_janeiro_2025.txt

cd ../backup 

rm backup_cliente_001.txt


-- Slide 16

cd ~/dimdim_bank

ls -la *

ls -l clientes
ls -l transacoes
ls -l relatorios
ls -l backup
ls -l logs



-- Slide 18

cd ~/dimdim_bank

cd logs 

touch sistema_dimdim.log acesso_usuarios.log transacoes_api.log erro_sistema.log

echo "2025-01-28 09:15:32 [INFO] Sistema DimDim iniciado com sucesso" > sistema_dimdim.log 
echo "2025-01-28 09:16:45 [INFO] Módulo de transações carregado" >> sistema_dimdim.log 
echo "2025-01-28 09:17:12 [ERROR] Falha na conexão com banco de dados" >> sistema_dimdim.log 
echo "2025-01-28 09:18:00 [INFO] Reconexão com banco estabelecida" >> sistema_dimdim.log 
echo "2025-01-28 09:20:15 [WARN] Alto volume de transações detectado" >> sistema_dimdim.log

echo "2025-01-28 08:30:15 LOGIN joao.silva 192.168.1.100 SUCCESS" > acesso_usuarios.log 
echo "2025-01-28 08:45:22 LOGIN maria.santos 192.168.1.101 SUCCESS" >> acesso_usuarios.log 
echo "2025-01-28 09:12:33 LOGIN pedro.oliveira 192.168.1.102 FAILED" >> acesso_usuarios.log 
echo "2025-01-28 09:13:01 LOGIN pedro.oliveira 192.168.1.102 SUCCESS" >> acesso_usuarios.log 
echo "2025-01-28 09:45:18 LOGOUT joao.silva 192.168.1.100" >> acesso_usuarios.log


-- Slide 19


echo "2025-01-28 10:15:30 API_CALL transfer amount=200.00 from=12345-6 to=98765-4" > transacoes_api.log 
echo "2025-01-28 10:16:45 API_CALL deposit amount=500.00 account=45678-9" >> transacoes_api.log 
echo "2025-01-28 10:18:22 API_CALL withdrawal amount=100.00 account=12345-6" >> transacoes_api.log 
echo "2025-01-28 10:25:15 API_CALL pix amount=150.00 from=98765-4 to=45678-9" >> transacoes_api.log

echo "2025-01-28 09:17:12 [ERROR] Database connection timeout - retrying..." > erro_sistema.log 
echo "2025-01-28 11:30:45 [ERROR] Invalid transaction amount: -50.00" >> erro_sistema.log 
echo "2025-01-28 14:22:18 [ERROR] User authentication failed for CPF 111.222.333-44" >> erro_sistema.log

cd ~/dimdim_bank

Buscar todos os arquivos .txt:
find . -name "*.txt"

Buscar arquivos de clientes específicos:
find . -name "*joao*"

Buscar apenas diretórios:
find . -type d


-- Slide 20

Buscar transações de João Silva:
grep -r "João Silva" .

Buscar erros nos logs:
grep "ERROR" logs/*.log

Buscar logins bem-sucedidos:
grep "SUCCESS" logs/acesso_usuarios.log

Buscar transações acima de R$ 200:
grep -E "(200|[3-9][0-9]{2}|[0-9]{4})" transacoes/transacoes_janeiro_2025.txt

Contar quantas vezes uma palavra aparece:
grep -c "Transferência" transacoes/transacoes_janeiro_2025.txt


-- Slide 21

Verificar uso geral do disco:
df -h

Verificar uso específico do diretório atual:
df -h .

Mostrar apenas sistemas de arquivos locais:
df -hT


-- Slide 22


Listar seus processos:
ps

Listar todos os processos detalhadamente:
ps -aux

Buscar processos específicos (simular busca por serviços bancários):
ps -aux | grep bash
ps -aux | grep <processo-a-procurar>

top


-- Slide 23

cd ~

rm -rf dimdim_bank  

