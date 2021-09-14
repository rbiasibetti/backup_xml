# Backup em XML - MS SQL Sever
Rotina para geração de backup em formato XML permitindo a exportação somente dos dados e estruturas sem a necessidade e geração do dump da base

O processo consiste em:
 * Gerar a exportação dos dados da base em formato XML, individualizando cada tabela em um arquivo específico
 * Realizar a compactação da pasta de backup

# Vantagens do processo

 * Permite a exportação dos dados de uma determinada base em formato XML, removendo a necessidade de dump da base do modo tradicional

# Informações adicionais

 * O processo de compressão foi desenvolvido utilizando o Winrar, no entanto, é possível a adaptação com outras ferramentas de compressão

