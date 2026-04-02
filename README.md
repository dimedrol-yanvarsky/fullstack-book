# Методичка: Фронтенд- и фуллстек-разработка

LaTeX-проект учебного пособия по JavaScript, React и Vue.

## Зависимости

- **TeX Live** (полная установка) или **MiKTeX** с автозагрузкой пакетов
- **latexmk** — система сборки (входит в TeX Live)
- **Python 3** + **Pygments** — для подсветки кода (пакет `minted`)
  ```
  pip install Pygments
  ```
- Шрифты: **CMU Serif** (Computer Modern Unicode), **JetBrains Mono**

## Сборка

```bash
cd methodbook
latexmk
```

PDF появится в `build/main.pdf`.

Для однократной сборки без latexmk:

```bash
xelatex -shell-escape -output-directory=build main.tex
biber build/main
xelatex -shell-escape -output-directory=build main.tex
xelatex -shell-escape -output-directory=build main.tex
```

Очистка артефактов:

```bash
latexmk -c
```

## Как добавить новую главу

1. Создай папку `chapters/04-название/`
2. Создай файл `chapters/04-название/chapter.tex`:
   ```latex
   \chapter{Название главы}
   Вводный текст главы.
   \input{chapters/04-название/01-первая-секция}
   ```
3. Добавь строку в `main.tex` перед `\printbibliography`:
   ```latex
   \input{chapters/04-название/chapter}
   ```

## Как добавить подглаву в существующую главу

1. Создай файл, например `chapters/01-javascript/04-closures.tex`:
   ```latex
   \section{Замыкания}
   Текст секции...
   ```
2. Добавь строку `\input` в соответствующий `chapter.tex`:
   ```latex
   \input{chapters/01-javascript/04-closures}
   ```

## Структура проекта

```
methodbook/
├── main.tex          — главный файл
├── preamble.tex      — пакеты, макросы, настройки
├── titlepage.tex     — титульная страница
├── references.bib    — библиография
├── chapters/         — главы и подглавы
├── images/           — иллюстрации
├── listings/         — внешние файлы кода
├── .latexmkrc        — конфиг latexmk
└── build/            — артефакты сборки (генерируется)
```
