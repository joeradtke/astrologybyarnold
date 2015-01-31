class TransitController < ApplicationController
  def new
    @transit=Transit.new
    @birthplace=Birthplace.all
  end

  def create
    @birth=Birth.new(transit_params)
    @birthplace=Birthplace.find(transit_params[:id])
    @birth=adjust_time(@birth,@birthplace)
    @birth2=Birth.new(:date=>parse_datetime_params(transit2_params,:date2))
    @out=eph(@birth,@birthplace)
    @long=long(@out)
    @speed=speed(@out)
    @house=house(@out)
    @hc=hc(@out)
    @out2=eph(@birth2,@birthplace)
    @long2=long(@out2)
    name=Digest::SHA1.hexdigest(Time.now.to_s)
    @image="#{name}.jpg"
    create_image(@image,@long,@house,@hc,"transit",@long2)
  end

  def transit_params
    params.require(:transit).permit(:name,:date,:id)
  end
  
  def transit2_params
    params.require(:transit).permit(:date2)
  end
end
