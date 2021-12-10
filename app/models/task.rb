class Task < ApplicationRecord
  validates :description, presence: true #validação do campo "descrição", presence: true = sempre presente
  validates :done, inclusion: [true, false] #validação do campo "concluido?"; validação para booleano é diferente; inclusion: [true, false] = irá incluir apenas verdadeiro ou falso; saber mais na documentação do rails https://guides.rubyonrails.org/active_record_validations.html#presence
end
