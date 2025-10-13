#!/usr/bin/env bash

set -e
echo "" > coverage.txt

export GOFLAGS=-mod=vendor

use_go_test=false
if command -v gotest; then
    use_go_test=true
fi

for d in $( find ./* -maxdepth 10 ! -path "./vendor*" ! -path "./.git*" ! -path "./scripts*" -type d); do
    if ls $d/*.go &> /dev/null; then
        args="-race -coverprofile=profile.out -covermode=atomic $d"
        if [ "$use_go_test" == true ]; then
            gotest $args
        else
            go test $args
        fi
        if [ -f profile.out ]; then
            cat profile.out >> coverage.txt
            rm profile.out
        fi
    fi
done






#!/usr/bin/env bash

# Interrompe o script se algum comando falhar.
set -e
# Cria um ficheiro de cobertura de testes vazio.
echo "" > coverage.txt

# Define flags para os comandos Go para usar o diretório 'vendor'.
export GOFLAGS=-mod=vendor

# Verifica se o comando 'gotest' está disponível para uma execução de teste otimizada.
use_go_test=false
if command -v gotest; then
    use_go_test=true
fi

# Itera sobre todos os subdiretórios do projeto (excluindo vendor, .git, scripts).
for d in $( find ./* -maxdepth 10 ! -path "./vendor*" ! -path "./.git*" ! -path "./scripts*" -type d); do
    # Se o diretório contiver ficheiros .go, executa os testes.
    if ls $d/*.go &> /dev/null; then
        args="-race -coverprofile=profile.out -covermode=atomic $d"
        if [ "$use_go_test" == true ]; then
            gotest $args
        else
            go test $args
        fi
        # Se um perfil de cobertura for gerado, anexa-o ao ficheiro principal e remove o temporário.
        if [ -f profile.out ]; then
            cat profile.out >> coverage.txt
            rm profile.out
        fi
    fi
done
