class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :description, null: false 
      t.date :due_date #Não coloquei not null/ null:false, pois esse campo vai ser
      t.boolean :done, default: false, null: false # default: false = Se o usuário não entar com um valor no momento da criação da tarefa, por padrão será atribuido o falso
      # null: false  = nunca vai pode ser nulo, a nível de banco de dados 

      t.timestamps
    end
  end
end
