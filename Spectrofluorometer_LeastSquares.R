######################################################################################
####################### Arthur Lima 2020.03.17 #######################################
# Script R para determinar a concentracao de pigmentos clorofilianos em amostras     #
# ambientais heterogenea. Traducao do script Matlab (Neveux, cedido pelo  Marcio).   # 
# Metodo de minimos quadrados descrito em Neveux & Lantoine (1993)                   # 
# Deep-Sea Research I (40) 1747; Tenorio et al (2005) Est Cost Shelf Sci 531.        #
######################################################################################

# Pacote 'nnls' necessario
install.packages("nnls")
require('nnls')

# Modificar o endereco para indicar a pasta onde estao os arquivos de amostras, branco e resultados
setwd("/home/arthurw/Documents/scripts/Pigment/170320/")

# Ler o arquivo com os metadados do processamento de extracao de pigmentos, contendo:
d <- read.table("./Metadados.Amostras.Pigmentos.csv", header=T, sep='\t')

# Ler o arquivo com os resultados do spectrofluorimetro para o branco (acetona 90%)
dBr <- read.table("./branco1.csv", header=T, sep=',', skip=1)


# Ler os resultados de excitacao e emissao de 6 pigmentos de referencia
# ('Chl a', 'Chl b', 'chl c1+2', 'Phe a', 'Phe b', 'Phe c')
dRef <- read.table("./CLS700V_6pig_2019.dat", sep='\t')
mref <- matrix(dRef$V1, nrow=1581,ncol=7)



# Criar o arquivo de saida e escrever o cabecalho
write.table(t(c('Amostra', 'Chl a', 'Chl b', 'chl c1+2', 'Phe a', 'Phe b', 'Phe c', 'H')),
            "Pigment.result.csv", row.names=F, sep=',', col.names=F, quote=F)

# Criar o arquivo de saida da solucao aproximada e escrever o cabecalho
write.table(t(c('Amostra', 'Chl a', 'Chl b', 'chl c1+2', 'Phe a', 'Phe b', 'Phe c', 'H')), 
            "Pigment.result.nnls.csv", row.names=F, sep=',', col.names=F, quote=F)



for (i in 1:length(d$Amostra)){
	linha=0
	linha0=0
	dd=0
	print(as.character(d[i,9]))
	
	# Checar a existencia do arquivo de resultados do espectrofluorimetro para cada amostra (d[,i9])
	# Confirmar se a matriz de resultados tem a mesma dimensao que a matriz de 
	# resultados do "Branco"
	# Resultados do espectrofluorimetro armazenado no objeto 'dd'

	if (file.exists(as.character(d[i,9]))){
	  dd <-read.table(as.character(d[i,9]), sep=',', header=T, skip=1)
	  if(dim(dd)[1]!=dim(dBr)[1]){
		  stop("Arquivos de branco e amostra nao compativeis")
	  }
	
	  # Criar um dataset corrigido, subtraindo os valores do "Branco" da "Amostra"
	  ddCor <- dd - dBr

	  # Separando os valores de volume filtrado d[i,4]- "Volume_Coleta_L"  e 
		# Extrado_dil (d[i,7] - "Volume_extrato_ml"*"Diluicao"
		ListaEmissaoAmostra <- c(d[i,4], d[i,7])
		
		# Arquivos de espectrofluorimetro organizados em pares de excitacao e emissao
		# Selecionado apenas os valores de emissao (colunas pares do arquivo de resultado). 
		# Valores de excitacao devem ser os mesmos entre referencias, Branco e amostra
		listJ <- seq(2,dim(dd)[2]-1, by=2)
	
		# Criar uma ListaEmissao das amostras de acordo com as emissoes lidas nos padroes de pigmentos.
		# Padroes foram lidos com 51 valores de excitacao e amostras foram lidas com 52 excitacoes. 
		# Considerando apenas os 51 primeiros valores de excitacao das amostras
		for(j in 1:51){
		  for (k in listJ){
			  ListaEmissaoAmostra <- c(ListaEmissaoAmostra, ddCor[j,k])
			  }
		  }

    # Fator de correcao das concentracaoes obtidas em funcao do volume filtrado 
		# e da diluicao para o espectrofluorimetro
		ve = 0.001 * ListaEmissaoAmostra[2] /ListaEmissaoAmostra[1]  
		dados = ListaEmissaoAmostra[3:1583]

	  # solucao exata - metodo de minimos quadrados
		dadosLS <- solve(t(mref) %*% mref)  %*% t(mref) %*% dados

		# solucao aproximada, removendo dados negativos
		dadosLS0 <-nnls(mref, dados)


		linha <- t(c(as.character(d[i,2]),ve*dadosLS))
		write.table(linha, "Pigment.result.csv", row.names=F, sep=',', append=T, col.names=F, quote=F)

	  linha0 <- t(c(as.character(d[i,2]),ve*dadosLS0$x))
		write.table(linha0, "Pigment.result.nnls.csv", row.names=F, sep=',', append=T, col.names=F, quote=F)
	}
}

print("Amostras encerradas. Merci Marcio Neveux.")

