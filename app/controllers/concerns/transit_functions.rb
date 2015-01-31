module TransitFunctions
    extend ActiveSupport::Concern

  def find_transits(longitude,longitude2,planetnames)
    asp_name=["Conjunction","Opposition","Trine","Square","Quincux","Sextile"]
    aspects=[]
    (0..9).each do |i|
      (0..9).each do |k|
	a=Aspect.new
	q=0
	da=(longitude2[i].to_f-longitude[k].to_f).abs
	if da>180
	  da=360-da
	end
	orb=2
	if da<=orb
	  q=1
	elsif (da-60).abs<orb
	  q=6
	elsif (da-90).abs<orb
	  q=4
	elsif (da-120).abs<orb
	  q=3
	elsif (da-150).abs<orb
	  q=5
	end
	if q>0
	#aspect exists
	  a.pn1=i
	  a.pn2=k
    	  a.p1name=planetnames[i]
	  a.p2name=planetnames[k]
	  a.name=asp_name[q-1]
	  aspects<<(a)
	end
      end
    end
    aspectstexts=[]
    aspects.each do |a|
      aspt=Aspecttext.where('pn1=? AND pn2=? AND name=?',a.pn1,a.pn2,a.name).first
      if aspt!=nil
        aspectstexts<<(aspt)
      end
    end
    return [aspects,aspectstexts]
  end
end
