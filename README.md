# GithuBrowser

GithuBrowser é uma pequena prova de conceito de utilização das APIs de busca do Github para navegar por repositórios. Este projeto está configurado para acessar os repositórios mais populares (de acordo com o número de stars) utilizando a linguagem de programação Swift.

Aviso: A implementação deste projeto encontra-se incompleta e portanto é possível a presença de falhas e comportamentos anomalos.

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
Devidos a imprevistos pessoais, este projeto desviou de suas definições arquiteturais, gerando uma dissonancia entre o planejamento realizado e a implementação atual.
A cobertura de testes se encontra abaixo do mínimo viavel e algumas classes apresentam uma arquitetura que dificulta a testabilidade.
Além disso, foi gerada uma dependencia do módulo de componentes (GBVisualComponents) com o módulo de chamadas de rede (GBDataFetcher), algo que a arquitetura original visava impedir para que ambos fossem o mais facilmente reutilizaveis e para que o projeto fosse mais performático.
Aliado a tudo isso, o gerenciamento de erros não foi implementado, gerando uma má experiencia e diminuindo a qualidade do projeto.

## Créditos
Este projeto utiliza elementos visuais cirados por terceiros sob licença aberta.
[Branch icons created by OwlDsgnr - Flaticon](https://www.flaticon.com/free-icons/branch)

