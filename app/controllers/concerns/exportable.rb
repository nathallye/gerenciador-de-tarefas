require "csv" # módulo CSV que já vem com o ruby

module Exportable
  extend ActiveSupport::Concern # objetivo do Concern é extraí código vários lugares repedidos para não precisar repetir código

  def export_csv
    headers = ["ID", "Descrição", "Finalizada?", "ID da tarefa pai", "Criada em", "Atualizada em"] # Cabeçalho do csv

    csv = CSV.generate(write_headers: true, headers: headers) do |row| # variável chamada "csv" onde chamamos o módulo CSV; * método .gerenate = retorna uma string do lado do servidor vai ser preparado a string e vai mandar para o navegador gerar o arquivo; * parâmetro write_headers: true = por padrão o rails não gera o cabeçalho e vamos informar que queremos ele; * headers: headers = em seguida especificamos o cabeçalho, onde foi colocada nessa variável "headers" para extrair o código e não deixar complicado; * do |row| = bloco que vai representar cada linha desse csv.
      Task.all.each do |task| # Task.all = retorna todas as tarefas; * each = para fazer um loop
        row << [ # row recebe um array com os dados de cada coluna do cabeçalho
          task.id,
          task.description,
          task.done? ? "Sim" : "Não",
          task.parent_id,
          I18n.l(task.created_at, format: :long),
          I18n.l(task.updated_at, format: :long)
        ]
        
      end
    end
    # essa string csv vamos jogar para dentro do send_data
    send_data csv, type: "text/csv; charset=utf-8; header=present", 
      disposition: "attachment; filename=" # especificações próprias para o navegador entender o tipo de arquivo a ser gerado
  end
  
end                      