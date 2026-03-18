# Desenvolvimento de Aplicativos em Shiny: Estatística na Pesquisa em Saúde

Este repositório contém o código desenvolvido durante o projeto de Iniciação Científica (IC) na Universidade Federal de Juiz de Fora. O objetivo principal foi implementar técnicas de Bioestatística, especificamente a Regressão Logística, em uma interface amigável e acessível para pesquisadores da área da saúde que não possuem domínio de programação.

---

## 📊 Sobre o Projeto

O aplicativo foi construído utilizando o pacote **Shiny** do software R, permitindo a criação de uma ferramenta interativa e gratuita (em contraste com softwares proprietários como o SPSS) para análise de desfechos binários.

### Principais Funcionalidades

- **Seleção de Arquivo:** Upload de bancos de dados personalizados no formato `.csv`.
- **Ajuste de Modelo:** Implementação de Regressão Logística com estimativa por Máxima Verossimilhança.
- **Seleção de Variáveis:** Interface interativa para remover variáveis não significativas e refinar o modelo.
- **Razão de Chances (Odds Ratio):** Cálculo e interpretação direta das chances de ocorrência do evento de interesse.
- **Análise de Diagnóstico:** Visualização de resíduos, pontos de alavanca e Distância de Cook através do pacote **GGally**.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** R  
- **Framework:** Shiny (`ui`, `server` e `shinyApp`)  
- **Visualização de Dados:** GGally  
- **Modelo Estatístico:** Regressão Logística (Distribuição de Bernoulli)  

---

## 📖 Exemplo de Uso (Pima Indians Diabetes)

Para demonstração, o projeto utiliza o banco de dados **Pima Indians Diabetes** (Kaggle), cujo objetivo é prever a ocorrência de diabetes em mulheres com base em variáveis como Glicose, IMC (BMI) e Idade.

No exemplo documentado, observou-se que variáveis como o nível de **Glicose** apresentam associação positiva com a probabilidade de ocorrência de Diabetes.

---

## 🎓 Créditos

- **Desenvolvedora:** Maria Júlia Neves Gregório  
- **Orientador:** Tiago Maia Magalhães  
- **Instituição:** Universidade Federal de Juiz de Fora (UFJF)
