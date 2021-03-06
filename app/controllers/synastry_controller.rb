class SynastryController < ApplicationController
  def new
    @synastry=Synastry.new
    @birthplace=Birthplace.all
    @birthplace2=Birthplace.all
  end

  def create
    @pageintro=Page.where('name=?','introduction').first
    @pagehouse=Page.where('name=?','houses').first
    @pageasp=Page.where('name=?','aspects').first
    @birth=Birth.new(synastry_params)
    @birthplace=Birthplace.find(synastry_params[:city])
    @birth=adjust_time(@birth,@birthplace)
    out=eph(@birth,@birthplace)
    long=long(out)
    speed=speed(out)
    house=house(out)
    hc=hc(out)
    date2=DateTime.civil_from_format(:utc,synastry2_params["date2(1i)"].to_i,synastry2_params["date2(2i)"].to_i,synastry2_params["date2(3i)"].to_i,synastry2_params["date2(4i)"].to_i,synastry2_params["date2(5i)"].to_i)
    @birth2=Birth.new(:date=>date2,:name=>synastry2_params[:name2])
    @birthplace2=Birthplace.find(synastry2_params[:city2])
    @birth2=adjust_time(@birth2,@birthplace2)
    out2=eph(@birth2,@birthplace2)
    long2=long(out2)
    house2=house(out2)
    hc2=hc(out2)
    name=Digest::SHA1.hexdigest(Time.now.to_s)
    @image="#{name}.jpg"
    create_image(@image,long,house,hc,"synastry",long2,hc2)
    planetnames=["Sun","Moon","Mercury","Venus","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto"]
    @planets=[]
    @houses=[]
    (0..9).each do |i|
      p=Planet.new
      p.name=planetnames[i]
      p.longitude=convert_longitude(long[i])
      p.longitude2=convert_longitude(long2[i])
      p.house=house[i].to_f.floor
      p.house2=house2[i].to_f.floor
      @planets.push(p)
    end
    (0..11).each do |i|
      h=House.new
      if i==0
	h.name="Ascendant"
      elsif i==9
	h.name="Midheaven"
      else
	h.name=i
      end
      h.longitude=convert_longitude(hc[i])
      h.longitude2=convert_longitude(hc2[i])
      @houses.push(h)
    end
    aspectdata=find_transits(long,long2,planetnames)
    @aspects=aspectdata[0]
    @planethouses=[]
    (0..9).each do |i|
      ph=Planethouse.where("planetno=? AND houseno=?",i,@planets[i].house).first
      if ph!=nil
        @planethouses.push(ph)
      end
    end
    @aspecttexts=findsynastrytexts(long,long2)
  end

  def synastry_params
    params.require(:synastry).permit(:name,:date,:city)
  end

  def synastry2_params
    params.require(:synastry).permit(:name2,:date2,:city2)
  end
end
