module DrawingFunctions
    extend ActiveSupport::Concern

  protected

  def create_image(image,long,house,hc,type="natal",long2=nil,hc2=nil)
    require 'RMagick'
    canvas=Magick::Image::new(700,700) {self.background_color='white'}
    i=Magick::Draw.new
    i.stroke('black')
    i.fill('white')
    #outer circle
    i.circle(350,350,50,350)
    #middle circle
    i.fill('#f084dc')
    i.circle(350,350,100,350)
    #inner circle
    i.fill('white')
    i.circle(350,350,200,350)
    #arrow for ascendent
    i.stroke('#0000ff')
    i.line(110,350,200,350)
    i.line(110,350,130,340)
    i.line(110,350,130,360)
    #house cusps
    (0..11).each do |n|
      xo=-250*Math.cos((hc[0].to_f-hc[n].to_f)*Math::PI/180)+350
      yo=-250*Math.sin((hc[0].to_f-hc[n].to_f)*Math::PI/180)+350
      xi=-150*Math.cos((hc[0].to_f-hc[n].to_f)*Math::PI/180)+350
      yi=-150*Math.sin((hc[0].to_f-hc[n].to_f)*Math::PI/180)+350
      if n!=0 && n!=9
        i.stroke('black')
        i.line(xo,yo,xi,yi)
      end
    end
    #arrow for MC
    angle=(hc[0].to_f-hc[9].to_f)*Math::PI/180
    xo=-(240)*Math.cos(angle)+350
    yo=-(240)*Math.sin(angle)+350
    xi=-150*Math.cos(angle)+350
    yi=-150*Math.sin(angle)+350
    i.stroke("#0000ff")
    i.line(xo,yo,xi,yi)
    angle1=115*Math::PI/180-angle
    angle2=25*Math::PI/180+angle
    x1=xo+(30*Math.cos(angle1))
    y1=yo+(30*Math.sin(angle1))
    i.line(xo,yo,x1,y1)
    x1=xo+(30*Math.cos(angle2))
    y1=yo+(30*Math.sin(angle2))
    i.line(xo,yo,x1,y1)
    #numbers for houses
    #below are lists for adjustments of position
    xpos0=[-5,-5,5,10,10,10,-5,-5,-10,-16,-16,-8]
    ypos0=[12,12,12,12,6,-6,-6,-6,-6,6,12,12]
    xadj=[10,5,5,5,5,5,10,10,10,16,16,16]
    yadj=[12,12,6,6,6,6,-6,6,6,12,12,6]
    (0..11).each do |m|
      angle=(hc[m].to_f-hc[0].to_f)*Math::PI/180
      x=xpos0[m]-(xadj[m]+150)*Math.cos(angle)+350
      y=ypos0[m]+(yadj[m]+150)*Math.sin(angle)+350
      i.stroke('black')
      i.fill('black')
      i.font('arial')
      i.font_size(12)
      i.text(x,y,(m+1).to_s)
    end
    offset=(hc[0].to_f-(((hc[0].to_f/30).floor*30))).to_i
    (0..11).each do |k|
      angle=(offset+30*k)*Math::PI/180
      x1=-250*Math.cos(angle)+350
      y1=-250*Math.sin(angle)+350
      x2=-300*Math.cos(angle)+350
      y2=-300*Math.sin(angle)+350
      i.line(x1,y1,x2,y2)
    end
    #unicode for signglyphs
    signglyphs=[97,115,100,102,103,104,106,107,108,122,120,99]
    #colors for glyphs
    colors=["#ff0000","#00ff00","#ed510e","#0000ff","#ff0000","#00ff00","#ed510e","#0000ff","#ff0000","#00ff00","#ed510e","#0000ff"]
    #add signglyphs 
    (0..11).each do |k|
      angle=(30*k-hc[0].to_f+10)*Math::PI/180
      centerposx=-7
      centerposy=6
      offsetposx=centerposx*Math.cos(angle)
      offsetposy=centerposx*Math.sin(angle)
      x1=centerposx+offsetposx-((275)*Math.cos(angle))+350
      y1=centerposy+offsetposy+((275)*Math.sin(angle))+350
      i.stroke(colors[k])
      i.fill(colors[k])
      i.font('HamburgSymbols.ttf')
      i.font_size(20)
      i.text_anchor(Magick::StartAnchor)
      i.text(x1,y1,signglyphs[k].chr(Encoding::UTF_8))
    end
    #draw the spokes of the wheel
    cnt=0
    (offset..offset+359).each do |k|
      x1=-250*Math.cos(k*Math::PI/180)
      y1=-250*Math.sin(k*Math::PI/180)
      if cnt%5==0
        x2=-241*Math.cos(k*Math::PI/180)
        y2=-241*Math.sin(k*Math::PI/180)
      else
        x2=-246*Math.cos(k*Math::PI/180)
        y2=-246*Math.sin(k*Math::PI/180)
      end 
      cnt=cnt+1
      i.stroke('black')
      i.line(x1+350,y1+350,x2+350,y2+350)
    end
    #put in the planets
    draw_planets(i,long,hc)
    if type=="natal"
    #draw in the aspect lines
      ar=sort_descending(long)
      sort=ar[0]
      sort_pos=ar[1]
      draw_aspect_lines(long,hc,sort,sort_pos,i)
    end
    if type=="nowtransit" || type=="transit"
      draw_planets(i,long2,hc,"red")
    elsif type=="synastry"
      draw_planets(i,long2,hc2,"yellow")
    end
    i.draw(canvas)
    canvas.write ("public/images/#{image}")
  end

  def display_planet_glyph(angle_to_use, radii)
    xy=[]
    # take into account the width and height of the glyph, defined below
    # get distance we need to shift the glyph so that the absolute middle of the glyph is the start point
    center_pos_x=-8
    center_pos_y=8

    #get the offset we have to move the center point to in order to be properly placed
    offset_pos_x=center_pos_x*Math.cos(angle_to_use)
    offset_pos_y=center_pos_y* Math.sin(angle_to_use)

    #now get the final X, Y coordinates
    xy[0]=center_pos_x+offset_pos_x+((-radii-10)*Math.cos(angle_to_use))
    xy[1]=center_pos_y+offset_pos_y+((radii+10)*Math.sin(angle_to_use))
    xy
  end

  def create_aspect_grid(image,long,hc)
    pl_name=["Sun","Moon","Mercury","Venus","Mars","Jupiter","Saturn","Uranus","Neptune","Pluto","Chiron","Lilith","True Node","P. of Fortune","Vertex","Ascendant","Midheaven"]
    signglyphs=[97,115,100,102,103,104,106,107,108,122,120,99]
    pglyphs=[81,87,69,82,84,89,85,73,79,80,77,96,141,60,109,90,88]
    asp_color=["#0000ff","#ff0000","#00ff00","#ff00ff","#00ffff","#ff7700"]
    asp_glyph=[113,119,101,114,111,116]
    ar=sort_descending(long)
    sort_pos=ar[1]
    require 'RMagick'
    canvas=Magick::Image::new(705,450) {self.background_color='white'}
    i=Magick::Draw.new
    #draw the grid - horizontal lines
    (0..14).each do |k|
      i.stroke("black")
      i.line(10,25*(k),10+25*(k),25*(k))
    #  i.line(10,25*15,10+25*k,25*15)
    end
    #draw the grid - vertical lines
    (1..15).each do |k|
      i.line(10+25*k,25*14,10+25*k,25*k)
      i.line(10,25*14,10,25)
    end
    #intiate aspect collection
    aspects=[]
    #draw in the planet glyphs
    (0..13).each do |k|
      i.stroke("black")
      i.fill("black")
      i.font("HamburgSymbols.ttf")
      i.font_size(20)
      i.text_anchor(Magick::StartAnchor)
      i.text(10+k*25,25*(k+1),pglyphs[k].chr(Encoding::UTF_8))
      (k+1..13).each do |l|
	a=Aspect.new
        q=0
        name=""
        da=(long[k].to_f-long[l].to_f).abs
	if da>180
	  da=360-da
	end
	if k==0 or k==1 or l==0 or l==1
	  orb=8
	else
	  orb=6
	end 
        re=calcaspect(da,orb)
        name=re[1]
        q=re[0]
	if name!=nil
	  a.pn1=k
	  a.pn2=l
	  a.name=name
	  aspects<<a
	  i.fill(asp_color[q-1])
	  i.text(10+25*(k+0.15),25*(l+1),asp_glyph[q-1].chr(Encoding::UTF_8))
        end
      end
      #display planet data in the right-hand table
      i.fill("black")
      i.text(10+(15.5*25),20+25*(k+1),pglyphs[k].chr(Encoding::UTF_8))
      i.font("Arial")
      i.font_size(10)
      i.stroke("blue")
      i.text(10+15.5*25+50,25*(k+2)-10,pl_name[k])
      sign_num=(long[k].to_f/30).floor
      i.fill("black")
      i.font("HamburgSymbols.ttf")
      i.font_size(14)
      i.stroke("black")
      i.text(25+15.5*25+25*5,25*(k+2)-8,signglyphs[sign_num].chr(Encoding::UTF_8))
      i.font("Arial")
      i.font_size(10)
      i.stroke("blue")
      i.text(45+15.5*25+25*6,25*(k+1)+15,convert_longitude(long[k]))
    end
    i.draw(canvas)
    canvas.write ("public/images/#{image}")
    return aspects
  end
end
