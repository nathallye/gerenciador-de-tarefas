class Task < ApplicationRecord
  validates :description, presence: true #validação do campo "descrição", presence: true = sempre presente
  validates :done, inclusion: [true, false] #validação do campo "concluido?"; validação para booleano é diferente; inclusion: [true, false] = irá incluir apenas verdadeiro ou falso; saber mais na documentação do rails https://guides.rubyonrails.org/active_record_validations.html#presence

  belongs_to :parent, class_name: "Task", optional: true  
  # pode pertencer a um parent, pois é opcional; class_name: = pois "parent" não é um model, portanto temos que especificar a classe a ser utilizada que vai ser "Task"

  has_many :sub_tasks, class_name: "Task", foreign_key: :parent_id, dependent: :destroy 
  # tem várias sub tarefas; class_name: = pois "sub_tasks" não é um model, portanto temos que especificar a classe a ser utilizada que vai ser "Task"; foreign_key: = especificar qual coluna do banco ele irá usar para fazer esse relacionamento; dependent: :destroy = se apagar uma tarefa, apagar todas as subtarefas associadas a ela.

  scope :only_parents, -> { where(parent_id: nil) } # prósito do escopo: em alguns casos vamos querer retornar somente as tarefas principais, não as subtarefas, e para isso é necessário fazer um filtro, uma "query"(solicitação) no banco de dados; vamos usar no controller para @tasks;
  # :only_parents = (só_pais) Nome do escopo; -> {} = passando um bloco de código; where(parent_id: nil) = query quando parent_id for nulo(não tiver);

  def parent?
    parent_id.nil? # esse método vai retornar true ou false
  end

  def sub_task?
    !parent? # se parent? for verdadeiro, sub_task vai ser falso (! retorna o inverso)
  end
  
  def done_subtasks? #chamar esse método no controller (update)
    count_total_subtasks = 0
    count_total_done = 0

    task_parent = self.parent
    task_parent.sub_tasks.each do |subtask|
      count_total_subtasks += 1
      if subtask.done == true
        count_total_done += 1
      end
    end

    if count_total_subtasks == count_total_done
      task_parent.done = true
      task_parent.save
    else
      task_parent.done = false
      task_parent.save
    end
  end
  
end

