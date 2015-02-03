class TransitController < ApplicationController
  def new
    @transit=Transit.new
    @birthplace=Birthplace.all
  end

  def create
    @pageintro=Page.where('name=?','introduction').first
    @pageaspect=Page.where('name=?','aspects').first
    @birth=Birth.new(transit_params)
    @birthplace=Birthplace.find(transit_params[:id])
    @birth=adjust_time(@birth,@birthplace)
    date2=DateTime.civil_from_format(:utc,transit2_params["date2(1i)"].to_i,transit2_params["date2(2i)"].to_i,transit2_params["date2(3i)"].to_i,transit2_params["date2(4i)"].to_i,transit2_params["date2(5i)"].to_i)
    @birth2=Birth.new(:date=>date2)
    @birth2=adjust_time(@birth2,@birthplace)
    out=eph(@birth,@birthplace)
    long=long(out)
    speed=speed(out)
    house=house(out)
    hc=hc(out)
    out2=eph(@birth2,@birthplace)
    long2=long(out2)
    name=Digest::SHA1.hexdigest(Time.now.to_s)
    @image="#{name}.jpg"
    create_image(@image,long,house,hc,"transit",long2)
    planetnames=["Sun","Moon","Mercury","Venus","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"]
    @planets=[]
    @houses=[]
    (0..9).each do |i|
      p=Planet.new
      p.name=planetnames[i]
      p.longitude=convert_longitude(long[i])
      p.longitude2=convert_longitude(long2[i])
      p.house=house[i].to_f.floor
      @planets.push(p)
    end
    (0..11).each do |i|
      h=House.new
      h.longitude=convert_longitude(hc[i])
      h.name=i+1
      @houses.push(h)
    end
    aspdata=find_transits(long,long2,planetnames)
    @aspects=aspdata[0]
    @aspectstexts=aspdata[1]
  end

  def transit_params
    params.require(:transit).permit(:name,:date,:id)
  end
  
  def transit2_params
    params.require(:transit).permit(:date2)
  end
end
