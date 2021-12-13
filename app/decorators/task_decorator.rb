class TaskDecorator < Draper::Decorator
  delegate_all # para deixar todos os meus métodos acesiveis

  def symbol
    case status #caso status da tarefa
    when "pending" then "•" #seja "pendente" então "exibir tal simbolo"
    when "done"    then "✔" #seja "concluída" então "exibir tal simbolo"
    when "expired" then "✗" #seja "prazo expirado" então "exibir tal simbolo"
    end
  end
  
  def css_color
    case status #caso status da tarefa
    when "pending" then "info" #seja "pendente" então "exibir tal cor"
    when "done"    then "success" #seja "concluída" então "exibir tal cor"
    when "expired" then "danger" #seja "prazo expirado" então "cor"
    end
  end

  private #método privado

  def status
    return "done" if task.done? # retornar "done" SE tarefa estiver finalizada ( done? => done = true (verdadeiro) )
      
    due_date.past? ? "expired" : "pending" # senão ele vai veridicar o due_date.past? = Se o prazo está no passado, se estiver retorna "expired", se estiver no futuro retorna "pending"
    # "?" e ":" = operadores ternários; 
    # ? se a condição for verdadeira exibir ""
    # : caso contrário exibir ""
  end

end