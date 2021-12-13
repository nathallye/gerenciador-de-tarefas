class AddParenteIdColumnToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :parent, foreign_key: { to_table: :tasks } # adicionar referência na tabela "tasks"; o nome do relacionamento é "parent"; e a foreign key (chave) para fazer o relacionamento, pois não existe uma tabela "parent", o que existe é a mesma tabela com o campo parent_id e vamos especificar qual é a tabela que contém esse campo, que no caso é a tabela "tasks"(to_table: :tasks)
  end
end
