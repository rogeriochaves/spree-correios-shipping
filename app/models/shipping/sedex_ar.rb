class Shipping::SedexAR < Shipping::BaseAR
  def self.description
    'Sedex com Aviso de Recebimento'
  end

  def tipo_servico
    :sedex
  end
end
