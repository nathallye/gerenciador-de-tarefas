Rails.application.routes.draw do
  root "tasks#index" #página inicial 

  resources :tasks, except: [:show] 
  # Quando utilizamos o resouces internamente o Rails tá adicionando 7 actions/rotas: index, show, new, create, edit, update e destroy

  # except: [:show]  = except para excluir uma rota, em seguida passamos um array de simbols de qual rota queremos excluir([:show] OU %i[show])
  # Não queremos nessa aplicação a rota show, pois nela vamos ter uma lista com as tarefas e não tem porque ter uma página só para mostrar os detalhes de uma tarefa, assim como é feito em outras aplicações como o blog, por exemplo. Apenas uma lista vai ser suficiente.

  # Feito isso, vamos apagar a action Show do controller(tasks_controller.rb)

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
