
# Note:
# any model that response to 'originrelated' (aka: "has_many :originrelateds, as: :originrelated"),
# must be implement all OriginrelatedProtocol methods below.
# 
module OriginrelatedProtocol
   
  # where the event came from.
  # 
  def origin
    return nil
  end

  # what's the orign name
  # 
  def origin_name
    return nil
  end

end


