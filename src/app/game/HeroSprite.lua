
local HeroSprite = class("HeroSprite")

function HeroSprite:ctor()

  	self.rightAnimate = nil 
  	self.downAnimate  = nil 
  	self.upAnimate    = nil 

  	--记录每次播放哪一帧
  	self.curUpCnt     = 0
  	self.curDownCnt   = 0
  	self.curLeftCnt   = 0
  	self.curRightCnt  = 0
  	self.passTime     = 0 

  	self.sprite       = nil
end

function HeroSprite:init()
end

function HeroSprite:createHero(heroData)
  	self.heroData   = heroData
  	self.heroPath   = heroData.heroPath
  	self.speed      = heroData.speed
  	self.heroWidth  = heroData.heroWidth
  	self.heroHeight = heroData.heroHeight

  	local spriteFrame = CCSpriteFrame:create(self.heroPath,CCRect(0,0,self.heroWidth,self.heroHeight))
  	self.sprite 	  = display.newSprite(spriteFrame)

    --self.sprite:setKeypadEnabled(true)

  	--self:initAnimate()
end

function HeroSprite:initAnimate()
  	local rightAnimation = self:createFrameAnimation(self.heroPath,self.heroWidth,self.heroHeight,0)
  	self.rightAnimate    = CCAnimate:create(rightAnimation)
  	local downAnimation  = self:createFrameAnimation(self.heroPath,self.heroWidth,self.heroHeight,self.heroHeight)
  	self.downAnimate     = CCAnimate:create(downAnimation)
  	local upAnimation    = self:createFrameAnimation(self.heroPath,self.heroWidth,self.heroHeight,self.heroHeight*2)
  	self.upAnimate       = CCAnimate:create(upAnimation)
end

function HeroSprite:createFrameAnimation(animationPath,width,height,startHeight)
  	local animation = CCAnimation:create()
  	animation:addSpriteFrame(CCSpriteFrame:create(animationPath,CCRect(0,startHeight,width,height)))
  	animation:addSpriteFrame(CCSpriteFrame:create(animationPath,CCRect(width*1,startHeight,width,height)))
  	animation:addSpriteFrame(CCSpriteFrame:create(animationPath,CCRect(width*2,startHeight,width,height)))
  	animation:addSpriteFrame(CCSpriteFrame:create(animationPath,CCRect(width*3,startHeight,width,height)))
  	animation:setRestoreOriginalFrame(true)
  	animation:setDelayPerUnit(0.1)
    return animation
end
function HeroSprite:getSprite()
    return self.sprite
end
function HeroSprite:update(ts)
	 self.passTime=self.passTime+dt
   
  


    
           --  if (!cc.sys.isNative)
           --  {
           --      if ((G_STATE.KEYS[cc.KEY.w] || G_STATE.KEYS[cc.KEY.up]) && this.y <= this._winSize.height)
           --      {
           --          this.y += dt * this._speed;
           --          if(this._passTime>=0.08)
           --          {
           --              this._curUpCnt++;
           --              this._curUpCnt=this._curUpCnt%4;
           --              this._passTime=0;
           --          }
           --          //this._curUpCnt++;
           --          //this._curUpCnt=this._curUpCnt%4;
           --          this.setSpriteFrame(cc.SpriteFrame.create(_arg.heroName,cc.rect(this._curUpCnt* _arg.heroWidth,_arg.heroHeight*2,_arg.heroWidth,_arg.heroHeight)));
           --      }
           --      else if ((G_STATE.KEYS[cc.KEY.s] || G_STATE.KEYS[cc.KEY.down]) && this.y >= 0)
           --      {
           --          this.y -= dt * this._speed;
           --          if(this._passTime>=0.08)
           --          {
           --              this._curDownCnt++;
           --              this._curDownCnt = this._curDownCnt % 4;
           --              this._passTime=0;
           --          }
           --          this.setSpriteFrame(cc.SpriteFrame.create(_arg.heroName,cc.rect(this._curDownCnt*_arg.heroWidth,_arg.heroHeight*1,_arg.heroWidth,_arg.heroHeight)));

           --      }
           --      else if ((G_STATE.KEYS[cc.KEY.a] || G_STATE.KEYS[cc.KEY.left]) && this.x >= 0)
           --      {
           --          this.x -= dt * this._speed;
           --          this._flippedX=true;
           --          if(this._passTime>=0.08)
           --          {
           --              this._curLeftCnt++;
           --              this._curLeftCnt = this._curLeftCnt % 4;
           --              this._passTime=0;
           --          }
           --          this.setSpriteFrame(cc.SpriteFrame.create(_arg.heroName,cc.rect(this._curLeftCnt*_arg.heroWidth,0,_arg.heroWidth,_arg.heroHeight)));

           --      }
           --      else if ((G_STATE.KEYS[cc.KEY.d] || G_STATE.KEYS[cc.KEY.right]) && this.x <= this._winSize.width)
           --      {
           --          this.x += dt * this._speed;
           --          this._flippedX=false;
           --          if(this._passTime>=0.08)
           --          {
           --              this._curRightCnt++;
           --              this._curRightCnt = this._curRightCnt % 4;
           --              this._passTime=0;
           --          }
           --          this.setSpriteFrame(cc.SpriteFrame.create(_arg.heroName,cc.rect(this._curRightCnt*_arg.heroWidth,0,_arg.heroWidth,_arg.heroHeight)));
           --      }
           --      else
           --      {
           --          this.setSpriteFrame(cc.SpriteFrame.create(_arg.heroName,cc.rect(0,_arg.heroHeight*1,_arg.heroWidth,_arg.heroHeight)));
           --      }
           --  }

           --  //console.log(dt);
           -- // this.setPosition(this.x,this.y);

           --  //if (this.HP <= 0) {
           --  //    this.active = false;
           --  //     this.destroy();
           --  // }
           --  //this._timeTick += dt;
           --  //if (this._timeTick > 0.1) {
           --  //    this._timeTick = 0;
           --  //    if (this._hurtColorLife > 0) {
           --  //        this._hurtColorLife--;
           --  //    }
           --  //}



end

return HeroSprite