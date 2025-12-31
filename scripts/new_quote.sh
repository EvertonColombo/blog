#!/bin/bash

# Pergunta os dados da frase
echo "✍️  Enter the quote text:"
read -r quote_text

echo "👤 Enter the author name:"
read -r author_name

echo "📅 Enter the year (default: 2026):"
read -r quote_year
if [ -z "$quote_year" ]; then
  quote_year=2026
fi

echo "🔗 Enter the source URL (optional, press Enter to skip):"
read -r source_url

# Define data e slug para o arquivo
current_date=$(date +%Y-%m-%d)
# Cria um slug simples
slug=$(echo "$author_name" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-">+</g')

# Define o nome do arquivo (mantemos o prefixo de data no nome para ordem de criação)
filename="quotes/posts/${current_date}-${slug}.qmd"

# Formata o link do autor
if [ -z "$source_url" ]; then
  author_markdown="— $author_name"
else
  author_markdown="— [$author_name]($source_url)"
fi

# Cria o arquivo .qmd com o conteúdo
cat <<EOF > "$filename"
---
title: "Quote by $author_name"
date: "$quote_year"
categories: [quotes]
---

::: {.quote-container}
::: {.quote-text}
"$quote_text"
:::
::: {.quote-author}
$author_markdown
:::
:::
EOF

echo "✅ Quote created successfully at: $filename"
echo "🚀 Run 'git add $filename && git commit -m \"Add quote by $author_name\" && git push origin main' to publish."
