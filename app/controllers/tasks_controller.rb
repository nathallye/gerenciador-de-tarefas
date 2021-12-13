class TasksController < ApplicationController # Classe TaksController herda de ApplicationCon...
  before_action :set_task, only: %i[edit update destroy] # before_action (antes de cada ação em português) = Metodo especial do Rails que explica para o controller que ele precisa rodar esse primeiro parâmetro :set_task, only (somente) para essas ações %i[edit update destroy]
  # :set_task é um método definido nesse arquivo
  
  # GET /tasks or /tasks.json 
  # Essas actions respondem por padrão tanto para /tasks quanto para/tasks.json (para funcionar como API)
  def index # A action INDEX retorna uma coleção de todos os registros(Task.all) e vai jogar para essa variável @tasks (o @ significa que essa variável vai ficar disponivél também nas views)
    @tasks = Task.order(due_date: :desc, description: :asc) #ordenar pelo prazo descrecente e quando tiverem a mesma data ordenar pela descrição de forma ascendente
  end

  def new # NEW é a página onde criamos um novo registro, por isso Task.new, assim vai ser criado um objeto vazio e quando salvamos no método CREATE ele pesiste com essas informações no banco de dados
    @task = Task.new
  end

  def edit #EDIT tem uma view parecida se não a mesma do new
  end

  def create # CREATE vai criar um registro novo 
    @task = Task.new(task_params)

    if @task.save # Se for salva
      redirect_to tasks_path, notice: t(".notice") # tasks_path = Por padrão o rails redireciona para a view show @task, portanto vamos alterar essa rota para o index
      # Fiz a trdução no arquivo pt-BR.yml e por isso usamos esse método t(".notice") para exibir as mensagens traduzidas de acordo com o idioma padrão do usuário
      
    else # Senão for salva
      flash.now[:alert] = @task.errors.full_messages.to_sentence # flash.now[:alert] = Exibir uma mensagem de alerta (é necessário usar .now quando em seguida temos um render e não um redirect_to); @post = Instancia do banco de dados; # .errors = Rach com varias informações sobre o erro; .full_messages = Retorna um array com todos os erros que ele encontrou; .to_sentence = Transforma tudo em uma frase.
      render :new, status: :unprocessable_entity 
    end
  end

  def update # UPDATE Pega um registro que já existe e salva as alterações 
    if @task.update(task_params)
      redirect_to tasks_path, notice: t(".notice") # tasks_path = Por padrão o rails redireciona para a view show @task, portanto vamos alterar essa rota para o index
      # Fiz a trdução no arquivo pt-BR.yml e por isso usamos esse método t(".notice") para exibir as mensagens traduzidas de acordo com o idioma padrão do usuário
    else
      flash.now[:alert] = @task.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy #DESTROY remove um registro do banco de dados
    @task.destroy
    redirect_to tasks_url, notice: t(".notice") # Fiz a trdução no arquivo pt-BR.yml e por isso usamos esse método t(".notice") para exibir as mensagens traduzidas de acordo com o idioma padrão do usuário
  end

  private # Métodos privados

  def set_task
    @task = Task.find(params[:id]).decorate # Define uma variável @task, que vai buscar no banco de dados de acordo com os params passado para essa action
    # .decorate = Para usarmos o padrão de projeto decorator
  end

  def task_params # Filtra os parâmetros/colunas do banco de dados que queremos permitir que o usuário passe para o controller/ possa acessar/alterar por questões de segurança
    params.require(:task).permit(:description, :due_date, :done)
  end
  
end
