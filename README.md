### AI trainer

## Description

Based on user input the AI trainer will recommend a set of exercises for a workout routine. It will also generate an image illustrating the different exercises part of the generated set:

<img align="right" width="400" src="https://res.cloudinary.com/dzaz6s9ar/image/upload/v1747655720/My_Movie_hfi0qj.gif" />

<br clear="right"/>

## Web App

The AI trainer is developed with Ruby and supported by the Rails framework. It follows the MVC pattern, uses Active Record as an interface for a PostgreSQL database. Authentication is operated through Devise. Generated text and image supported by OpenAI’s API.

![ruby](https://img.shields.io/badge/Ruby-3.1.2-F32C24?style=for-the-badge&logo=ruby&logoColor=white) ![Rails](https://img.shields.io/badge/Rails-7.1.5-C52F24?style=for-the-badge&logo=rubyonrails&logoColor=white) ![JavaScript](https://img.shields.io/badge/JavaScript-ES6-yellow?style=for-the-badge&logo=javascript&logoColor=white) ![SCSS](https://img.shields.io/badge/SCSS-3.5-BF4080?style=for-the-badge&logo=sass&logoColor=white) ![HTML](https://img.shields.io/badge/HTML-5-E34F26?style=for-the-badge&logo=html5&logoColor=white) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14.6-4764BE?style=for-the-badge&logo=postgresql&logoColor=white) ![Bootstrap](https://img.shields.io/badge/Bootstrap-5-7852B2?style=for-the-badge&logo=bootstrap&logoColor=white)

## Ruby gems (non exhaustive)

[![simple_form](https://img.shields.io/badge/simple_form-5.1.0-red.svg)](https://rubygems.org/gems/simple_form) [![cloudinary](https://img.shields.io/badge/cloudinary-2.3.0-red.svg)](https://rubygems.org/gems/cloudinary) [![ruby-openai](https://img.shields.io/badge/ruby--openai-8.1.2-red.svg)](https://rubygems.org/gems/ruby-openai)

## Run Locally

Clone the project

```bash
  git clone https://github.com/maricalmer/ai_workout.git my-project
```

Go to the project directory and remove git logs

```bash
  cd my-project
  rm -rf .git
```

Get an API key from OpenAI

```bash
  echo OPENAI_ACCESS_TOKEN=YOUR_API_KEY > .env
```

Install dependencies

```bash
  bundle install
  yarn install
```

Create database with seeds

```bash
  rails db:create db:migrate db:seed
```

Start the server

```bash
  rails s
```


## License

[MIT](https://choosealicense.com/licenses/mit/)
