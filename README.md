# GithuBrowser

GithuBrowser é uma pequena prova de conceito de utilização das APIs de busca do Github para navegar por repositórios. Este projeto está configurado para acessar os repositórios mais populares (de acordo com o número de stars) utilizando a linguagem de programação Swift.

## Instalação
* Necessário: XCode 13
Este projeto não utiliza nenhuma biblioteca de terceiros. Para rodar este projeto, simplesmente clone o repositório e execute o projeto utilizando a versão mais recente, se possível, do XCode. 
As bibliotecas de código utilizadas se encontram dentro da pasta ProjectPackages e utilizam o Swift Package Manager como gerenciador de dependencias, portanto não necessitam de comandos de instalação.

## Módulos
Este projeto visa segregar o código visando facilitar o reuso e manutenção futura através de módulos. 
Foram criados dois módulos:
* GBDataFetcher
Responsável por abstrair a camada de rede e logística de chamadas do módulo.
* GBVisualComponents
Responsável por conter as classes e componentes visuais criados para o projeto.

## Arquitetura
### Conceito
Este projeto utiliza uma arquitetura baseada no Model View Presenter (MVP) com a inclusão de Coordinators para navegação e controle de fluxo.
Com o intuito de facilitar o reuso e manutenção do código, utilizou-se módulos para segregar camadas do projeto. O uso de programação orientada a protocolos também foi feita, a fim de facilitar a leitura e aumentar a testabilidade do código.
### Débitos técnicos
A cobertura de testes se encontra abaixo do desejado, em especial na biblioteca GBDataFetcher e na GBAppFlows.
Algumas funcionalidades como o gerenciamento de falhas no decorrer de fluxos e estados de erro ainda se encontram pendentes. 
Por fim, o projeto inicia diretamente na tela da lista de repositórios Swift e seria desejesavel uma tela de inicio antes para melhor faciltiar a experiencia e os testes, além de possibilitar a configuração da chamada da tela de repositórios. 

## Créditos
Este projeto utiliza elementos visuais cirados por terceiros sob licença aberta.
[Branch icons created by OwlDsgnr - Flaticon](https://www.flaticon.com/free-icons/branch)

