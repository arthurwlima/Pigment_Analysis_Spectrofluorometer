# Pigment_Analysis_Spectrofluorometer
Analise de concentracao de pigmentos clorofilianos em amostras ambientais heterogeneas

Script R para determinar a concentracao de pigmentos clorofilianos em uma amostra ambiental heterogenea. 
Traducao/adaptacao do script Matlab (Neveux, cedido pelo Marcio Tenorio). Metodo de minimos quadrados descrito em:
Neveux & Lantoine (1993) Deep-Sea Research I (40) 1747; Tenorio et al (2005) Est Cost Shelf Sci 531.

Amostras ambientais sao filtradas em filtros GF/F e os pigmentos da amostra sao extraidos em acetona 90%. 
Amostras lidas em espectrofluorimetro Varian Cary Eclipse, com excitacoes entre XXX e XXX. 
Para cada faixa de excitacao sao registrados os valores de emissao da amostra em XXX faixas.

O padrao de fluorescencia da amostra depende dos diferentes pigmentos contidos, alem da concentracao de cada um deles.
Assim, para cada valor de excitacao, o valor de emissao observado na amostra é uma combinacao linear da fluorescencia emitida pelos diferentes pigmentos.

Em forma matricial:

FluorAmostra = concentracoes x Referencias

FluorAmostra - [1,1581]
concentracoes - [1,6]
Referencias - [6,1581]


Script depende de quatro arquivos de entrada (.csv) e retorna dois arquivos (.csv) com as concentracoes estimadas dos pigmentos (mg/L).
Arquivos de entrada:
- Arquivo metadados 
- Arquivo Fluorescencias do Branco
- Arquivo Fluorescencias das Referencias
- Arquivo Fluorescencias da amostra

Saida:
- Concentracao dos pigmentos a partir da solucao exata do metodo de minimos quadrados. Pode ter concentraóes com valores negativos;
- Concentracao dos pigmentos a partir da solucao aproximada, removendo valores negativos.


Arquivo metadados:
Ponto_campo; Amostra; Data; Volume_Coleta_L; Volume_extrato_ml; Diluicao; Extrato_Dil; Nome_Fluor
Ponto_campo       - Ponto de Coleta
Amostra           - Codigo da Amostra
Data              - Data de coleta
Volume_Coleta_L   - Volume da coleta em litros
Volume_extrato_ml - Volume da extracao em mL
Diluicao          - Diluicao usada pra ler o extrato no espectrofluorimetro
Extrato_Dil       - Porduto entre o volume do extrato e a diluicao
Nome_Fluor        - Nome do arquivo que contem os resultados de fluorescencia de cada amostra


Dois pontos importantes:
1 - O cabecalho do arquivo de metadados esteja na ordem listada acima.
2 - O usuario deve garantir que os valores de emissao e excitacao das referencias, branco e amostras foram realizados nas mesmas faixas

Nos arquivos de exemplo, foram lidos 31 valores de emissao em 51 diferentes valores de excitacao, em um total de 1581 observacoes por amostra.
