class NatalController < ApplicationController
  def new
    @natal=Natal.new
    @birthplace=Birthplace.all
  end

  def create
    birth=Birth.new(natal_params)
    @birthplace=Birthplace.find(natal_params[:id])
    @birth=adjust_time(birth,@birthplace)
    @pageintro=Page.where('name=?','introduction').first
    @pageinfl=Page.where('name=?','influence').first
    @pagehouse=Page.where('name=?','houses').first
    @pageasp=Page.where('name=?','aspects').first
    out=eph(@birth,@birthplace)
    long=long(out)
    speed=speed(out)
    house=house(out)
    hc=hc(out)
    name=Digest::SHA1.hexdigest(Time.now.to_s)
    @image="#{name}.jpg"
    name2=Digest::SHA2.hexdigest(Time.now.to_s)
    @image2="#{name2}.jpg"
    create_image(@image,long,house,hc)
    aspects=create_aspect_grid(@image2,long,hc)
    ascend=find_ascendant_sign(hc[0])
    @ascendant=Ascendant.where('sign_no=?',ascend)
    @planets=[]
    (0..9).each do |i|
      p=Planet.new
      p.longitude=convert_longitude(long[i])
      p.house=house[i].to_f.floor-1
      @planets.push(p)
    end
    @planetsigns=[]
    @planethouses=[]
    (0..9).each do |i|
      sign=(long[i].to_f/30).floor
      ps=Planetsign.where("planetno=? AND signno=?",i,sign).first
      if ps!=nil
        @planetsigns.push(ps)
      end
      ph=Planethouse.where("planetno=? AND houseno=?",i,@planets[i].house).first
      if ph!=nil
        @planethouses.push(ph)
      end
    @aspecttexts=findaspecttext(long)
    @aspectatexts=findaspectatext(long,hc)
    end
  end

  def natal_params
    params.require(:natal).permit(:name,:date,:city,:id)
  end
end
