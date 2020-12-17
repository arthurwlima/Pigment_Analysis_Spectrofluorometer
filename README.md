# Pigment_Analysis_Spectrofluorometer
Analise de concentracao de pigmentos clorofilianos em amostras ambientais heterogeneas

Script R para determinar a concentracao de pigmentos clorofilianos em uma amostra ambiental heterogenea. 
Traducao/adaptacao do script Matlab (Neveux, cedido pelo Marcio). Metodo de minimos quadrados descrito em:
Neveux & Lantoine (1993) Deep-Sea Research I (40) 1747; Tenorio et al (2005) Est Cost Shelf Sci 531.

Amostras ambientais sao filtradas em filtros GF/F e os pigmentos da amostra sao extraidos em acetona 90%. 
Amostras lidas em espectrofluorimetro Varian Cary Eclipse, com excitacoes entre 614.9nm e 714.9nm. 
Para cada faixa de excitacao sao registrados os valores de emissao da amostra em 31 faixas.

Nos arquivos de exemplo, foram lidos 31 valores de emissao em 51 diferentes comprimentos de onda de excitacao, em um total de 1581 observacoes por arquivo (amostras, branco e referencias).

O padrao de fluorescencia da amostra depende dos diferentes pigmentos contidos, alem da concentracao de cada um deles.
Assim, para cada valor de excitacao, o valor de emissao observado na amostra é uma combinacao linear da fluorescencia emitida pelos diferentes pigmentos.

**Modo de Executar**

Abrir o arquivo "Espectrofluorimetro.AnalisePigmentos.R" no R/RStudio e executar os comandos bloco a bloco.

Script depende de quatro arquivos de entrada (.csv) e retorna dois arquivos (.csv) com as concentracoes estimadas dos pigmentos (mg/L). 
**Os arquivos de entrada devem estar todos na mesma pasta**
   
**Arquivos de entrada:**
- Arquivo metadados das amostras, contendo os volumes filtrados 
- Arquivo com as emissoes de fluorescencia para cada comprimento de excitação do **Branco**
- Arquivo com as emissoes de fluorescencia para cada comprimento de excitação das **Referencias**
- Arquivo com as emissoes de fluorescencia para cada comprimento de excitação da **Amostra**


**Saida:**
- Concentracao dos pigmentos na amostra, a partir da solucao exata do metodo de minimos quadrados. Pode ter concentrações com valores negativos;
- Concentracao dos pigmentos na amostra, a partir da solucao aproximada removendo valores negativos.


**Arquivo metadados:**

**Ponto_campo; Amostra; Data; Volume_Coleta_L; Volume_extrato_ml; Diluicao; Extrato_Dil; Nome_Fluor**
- Ponto_campo       : Ponto de Coleta
- Amostra           : Codigo da Amostra
- Data              : Data de coleta
- Volume_Coleta_L   : Volume da coleta em litros
- Volume_extrato_ml : Volume da extracao em mL
- Diluicao          : Diluicao usada pra ler o extrato no espectrofluorimetro
- Extrato_Dil       : Porduto entre o volume do extrato e a diluicao
- Nome_Fluor        : Nome do arquivo que contem os resultados de fluorescencia de cada amostra


**Importante:**

1 - É fundamental garantir que o arquivo de metadados tenha a estrutura listada acima. Na duvida, comparar com o arquivo "Metadados.Amostras.Pigmentos.csv", no link de cima da pagina.

2 - Garantir que foram usados os mesmos valores de emissao e excitacao para as referencias, branco e amostras.

3 - Renomear os arquivos de saida no script, se for executar o novamente na mesma pasta. Caso contrario, o script ira sobreescrever o resultado anterior.
