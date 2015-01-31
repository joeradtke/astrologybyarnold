class NowtransitController < ApplicationController
  def new
    @transitnow=Transitnow.new
    @birthplace=Birthplace.all
  end

  def create
    @pageintro=Page.where('name=?','introduction').first
    @pageaspect=Page.where('name=?','aspects').first
    @birth=Birth.new(nowtransit_params)
    @birthplace=Birthplace.find(nowtransit_params[:id])
    @birth=adjust_time(@birth,@birthplace)
    @out=eph(@birth,@birthplace)
    @long=long(@out)
    @speed=speed(@out)
    @house=house(@out)
    @hc=hc(@out)
    @out2=eph(@birth2,@birthplace,"nowtransit")
    @long2=long(@out2)
    name=Digest::SHA1.hexdigest(Time.now.to_s)
    @image="#{name}.jpg"
    create_image(@image,@long,@house,@hc,"nowtransit",@long2)
    planetnames=["Sun","Moon","Mercury","Venus","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"]
    @planets=[]
    @houses=[]
    (0..9).each do |i|
      p=Planet.new
      p.name=planetnames[i]
      p.longitude=convert_longitude(@long[i])
      p.longitude2=convert_longitude(@long2[i])
      p.house=@house[i].to_f.floor
      @planets.push(p)
    end
    (0..11).each do |i|
      h=House.new
      h.longitude=convert_longitude(@hc[i])
      h.name=i+1
      @houses.push(h)
    end
    aspdata=find_transits(@long,@long2,planetnames)
    @aspects=aspdata[0]
    @aspectstexts=aspdata[1]
  end

  def nowtransit_params
    params.require(:transitnow).permit(:name,:date,:city,:id)
  end
end
