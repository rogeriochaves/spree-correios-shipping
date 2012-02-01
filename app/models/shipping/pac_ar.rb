class Shipping::PacAR < Shipping::BaseAR
  def self.description
    'Pac com Aviso de Recebimento'
  end

  def tipo_servico
    :pac
  end
end
