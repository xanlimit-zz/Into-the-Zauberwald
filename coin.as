package  {



    import flash.display.MovieClip;
	import flash.display.DisplayObject;

    import flash.events.*;

    import flash.events.Event;
	
	import flash.media.SoundChannel;

	//import the Tween class
	import fl.transitions.Tween;
	//import the transitions
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	 
	//create a var tween
	

    public class coin extends MovieClip {


		var sndBGMusicChannel: SoundChannel = new SoundChannel();
		var t1:Pickitemsfx = new Pickitemsfx;
			
        var player:DisplayObject;

        var mainTimeLine = MovieClip(root);

        var coinValue:int = 1;

		

        public function coin() {

            // constructor code

            this.addEventListener(Event.ENTER_FRAME, upDate);

        }



        function upDate (e:Event) :void {
		
			
			if(Main.playerINT == 6)
			player = Main.player;
			else
			player = Main.getStage().getChildAt(Main.playerINT);


            if (this.hitTestObject(player)) {

                this.removeEventListener(Event.ENTER_FRAME, upDate);
				var tween:Tween;
				tween = new Tween(this, "x", Regular.easeOut, this.x, this.x - 450, 1.5, true);
				tween = new Tween(this, "y", Regular.easeOut, this.y, -700, 1.5, true);
				tween.addEventListener(TweenEvent.MOTION_FINISH, startTween);
 
				//create the functions startTween2 and startTween3
				
				sndBGMusicChannel = t1.play();
				Main.coinCount += coinValue;

            }

        }

function startTween(event:TweenEvent):void {
					//make tween2 start
					this.visible = false;
				}

    }



}