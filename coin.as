package  {



    import flash.display.MovieClip;

    import flash.events.*;

    import flash.events.Event;
	
	import flash.media.SoundChannel;



    public class coin extends MovieClip {


		var sndBGMusicChannel: SoundChannel = new SoundChannel();
		var t1:Pickitemsfx = new Pickitemsfx;
			
        var player:MovieClip;

        var mainTimeLine = MovieClip(root);

        var coinValue:int = 1;



        public function coin() {

            // constructor code

            this.addEventListener(Event.ENTER_FRAME, upDate);

        }



        function upDate (e:Event) :void {

            mainTimeLine = MovieClip(root);

			player = mainTimeLine.player;



            if (this.hitTestObject(player)) {

                this.removeEventListener(Event.ENTER_FRAME, upDate);

                this.visible = false;
				sndBGMusicChannel = t1.play();
                mainTimeLine.coinCount += coinValue;

            }

        }



    }



}