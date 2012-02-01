require 'correios-frete'

class Shipping::BaseAR < Shipping::Base
  def compute(object)
    pedido = encontra_pedido(object)

    peso_total = peso_total_do_pedido(pedido)

    return 0 if peso_total == 0
    
    frete = Correios::Frete::Calculador.new :cep_origem => preferred_zipcode,
                                :cep_destino => pedido.ship_address.zipcode.to_s,
                                :peso => peso_total,
                                :comprimento => 30,
                                :largura => 15,
                                :altura => 2,
                                :aviso_recebimento => true

    servico = frete.calcular self.tipo_servico
    servico.valor
  end

  private

  def peso_total_do_pedido(pedido)
    peso_total = 0
    pedido.line_items.each do |item|
      peso_total += item.quantity * (item.variant.weight || self.preferred_default_weight)
    end
    peso_total
  end

  def encontra_pedido(object)
    if object.is_a?(Array)
      order = object.first.order
    elsif object.is_a?(Shipment)
      order = object.order
    else
      order = object
    end
    order
  end

end
