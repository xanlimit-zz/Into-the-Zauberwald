package{



	import flash.display.MovieClip;

	import flash.display.Loader;

	import flash.events.Event;

	import flash.events.KeyboardEvent;

	import flash.ui.Keyboard;

	import flash.events.TimerEvent;

	import flash.net.URLRequest;

	import flash.utils.Timer;

	import flash.display.StageScaleMode;

	import flash.media.Sound;

	import flash.media.SoundChannel;

	import flash.media.SoundTransform;

	import fl.transitions.*;

	import fl.transitions.easing.*;
	import flash.display.Stage;

	public class Main3 extends MovieClip {

		//importing swf:
		var sndBGMusicChannel: SoundChannel = new SoundChannel();
		var St1: SoundTransform = new SoundTransform();
		var jumpChannel:SoundChannel = new SoundChannel();
		var j1:jumpSFX = new jumpSFX();
		var b1: cfmBT = new cfmBT;
		var s1:FX = new FX();
		var f1:FSBGM = new FSBGM();
		var t1:gameplay = new gameplay;
		var white:whiteBG = new whiteBG();
		var listBox:Array = new Array;
		var t2: topbottom = new topbottom;
		

		//	importing movieclips:
		var coins_txt:coins_mc = new coins_mc;
		var player: player_mc = new player_mc;
		var collisions: collisions_mc3;
		var hills: hills_mc = new hills_mc;
		var hills2: hills2_mc = new hills2_mc;
		var hills3: hills3_mc = new hills3_mc;
		var hills4: hills4_mc = new hills4_mc;
		

		//	player settings (have a good play around with these to get the effects you want):

		var player_topSpeed: Number = 6; //	This is the fastest the player will be able to go
		var player_acceleration: Number = 1; //	The speed that the player speeds up
		var player_friction: Number = 1; //	The speed that the player slows down once key is let go
		var player_1stJumpHeight: Number = -20; //	The first jump height
		var player_2ndJumpHeight: Number = -15; //	If player_doubleJump is true, this will be height of second jump
		var player_gravity: Number = 1; //	The acceleration of the fall.
		var player_maxGravity: Number = 20; //  The fastest the player will be able to fall
		var player_doubleJump: Boolean = true; //	Determinds whether player will double jump or not
		var player_bounce: Boolean = false; //	Determinds whether player will bounce off the walls like a ball
		var player_bounciness: Number = -0.05; //	How bouncy the player will be if player_bounce is true
		var player_sideScrollingMode: Boolean = true; //	Determinds whether player or background moves.
		var movingB: Boolean = true;
		var jumping: Boolean = false;

		// other player variables:

		var player_currentSpeed: Number; //  To help the calculations on the speed of player
		var player_doubleJumpReady: Boolean = false;
		var player_inAir: Boolean = false;
		var player_xRight: Number = 0;
		var player_xLeft: Number = 0;
		var player_y: Number = 0;
		var leftTurn: Boolean = false;
		var rightTurn: Boolean = false;
		var playerOnLift: Boolean = false;
		var scaleIt: Number = 0;
		var held: Boolean = false;
		
		var downBumping, leftBumping, upBumping, rightBumping, underBumping, jumpBumping: Boolean = false;

		var leftPressed, rightPressed, upPressed, downPressed, spacePressed, shiftPressed: Boolean = false;

		
		

		
		

		public function Main3() {
			
			Main.player = this.player;
			
			Main.getStage().addChild(hills);
			
			Main.getStage().addChild(hills2);
			Main.getStage().addChild(hills3);
			Main.getStage().addChild(hills4);
			Main.playerINT = 7;
			collisions= new collisions_mc3;
			Main.getStage().addChild(collisions);
			
			Main.getStage().addChild(coins_txt);
			Main.getStage().addChild(player);
			
			trace(Main.getStage().getChildAt(7));
			
			coins_txt.x = 25;
			coins_txt.y = 25;
			
			//player.scaleX = 0.4;
			//player.scaleY = 0.4;
			player.height *= 0.4;
			player.width *= 0.4;
			
			
			
			
			
			sndBGMusicChannel = t1.play();
			
			//sndBGMusicChannel.soundTransform = new SoundTransform(0.5, 0.0);
			
			player.x = 100;
			player.y = Main.getStage().stageHeight - 100;
			
			collisions.x = 0;

			collisions.y = Main.getStage().stageHeight;

			//sky.x = stage.stageWidth/2;

			//sky.y = stage.stageHeight/1.5;

			hills.x = 0;
			hills.y = Main.getStage().stageHeight;
			hills2.x = 0;
			hills2.y = Main.getStage().stageHeight;
			hills3.x = 0;
			hills3.y = Main.getStage().stageHeight;
			hills4.x = 0;
			hills4.y = Main.getStage().stageHeight;

			collisions.visible = true;
			collisions.ground3.visible = false;
			
			
			Main.getStage().addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			Main.getStage().addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			listBox.push("Girl" + "\n" + "Next is Sympathize.... "+"\n"+"I need to collect 10 orbs...");
			dialogue(listBox);
			
		}



		function removeGame() {
			Main.getStage().removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			Main.getStage().removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

			removeChild(hills);
			removeChild(collisions);
			removeChild(player);
		}



		function onEnterFrameHandler(e: Event) {
			if ((collisions.ground3.hitTestPoint(player.x + player.width * 0.8 / 6, player.y, true)) ||
				(collisions.ground3.hitTestPoint(player.x - player.width * 0.8 / 6, player.y, true)) ||
				(collisions.ground3.hitTestPoint(player.x, player.y, true))) {
				downBumping = true;
			} else {
				downBumping = false;
			}

			if (collisions.ground3.hitTestPoint(player.x, player.y + 7, true)) {
				jumpBumping = true;
			} else {
				jumpBumping = false;
			}

			if (collisions.ground3.hitTestPoint(player.x, player.y - 2, true)) {
				underBumping = true;
			} else {
				underBumping = false;
			}

			if ((collisions.ground3.hitTestPoint(player.x - player.width * 0.8 / 2, player.y - player.height * 0.8 / 2, true)) ||
				(collisions.ground3.hitTestPoint(player.x - player.width * 0.8 / 2, player.y - player.height * 0.9, true)) ||
				(collisions.ground3.hitTestPoint(player.x - player.width * 0.8 / 2, player.y - 2, true))) {
				leftBumping = true;
			} else {
				leftBumping = false;
			}
			
			if ((collisions.touch_mc.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.8 / 2, true)) ||
				(collisions.touch_mc.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.9, true)) ||
				(collisions.touch_mc.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - 2, true))) {
				if(Main.coinCount == 10){
					successGame();
				}
				
			}
			
			
			if ((collisions.ground3.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.8 / 2, true)) ||
				(collisions.ground3.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.9, true)) ||
				(collisions.ground3.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - 2, true))) {
				rightBumping = true;
			} else {
				rightBumping = false;
			}

			if (collisions.ground3.hitTestPoint(player.x, player.y - player.height * 0.8, true)) {
				upBumping = true;
			} else {
				upBumping = false;
			}
			if (collisions.restart.hitTestPoint(player.x, player.y, true)) {

				sndBGMusicChannel.stop();
				//removeChild(player);
				failScreen();

			}




			if (rightPressed) {
				player.scaleX = 0.4;
				rightTurn = true;
				//if(movingB)player.gotoAndPlay(65);
				if (player_xRight < player_topSpeed) {
					player_xRight += player_acceleration;
				}
			} else {
				rightTurn = false;
				if (player_xRight > 0.5) {
					player_xRight -= player_friction;
				} else if (player_xRight < -0.5 && player_xRight > 10) {
					player_xRight += player_friction;
				} else {
					player_xRight = 0;
				}
			}

			if (leftPressed) {
				player.scaleX = -0.4;
				//if(movingB)player.gotoAndPlay(65);
				leftTurn = true;
				if (player_xLeft < player_topSpeed) {
					player_xLeft += player_acceleration;
				}
			} else {
				leftTurn = false;
				if (player_xLeft > 0.5) {
					player_xLeft -= player_friction;
				} else if (player_xLeft < -0.5 && player_xLeft > 15) {
					player_xLeft += player_friction;
				} else {
					player_xLeft = 0;
				}
			}



			if (rightBumping) {
				if (player_bounce) {
					player_xRight *= player_bounciness;
				} else {
					player_xRight = 0;
				}
			}

			if (leftBumping) {
				if (player_bounce) {
					player_xLeft *= player_bounciness;
				} else {
					player_xLeft = 0;
				}
			}

			if (upBumping) {
				player_y = 1;
			}

			if (!playerOnLift) {
				if (downBumping) {
					player_y = 0;
					player_inAir = false;
				} else {
					if (player_y < player_maxGravity) {
						player_y += player_gravity;
					}
				}
				if (underBumping) {
					player_y = -2;
				}
			}

			if (upPressed) {
				jumping = true;
				if (jumpBumping) {
					player_y = player_1stJumpHeight;
					player_doubleJumpReady = false;
					player_inAir = true;
					jumpChannel = j1.play(0,1);
					jumpChannel.soundTransform = new SoundTransform(0.2, 0.0);
					
				}

				if (player_doubleJumpReady && player_inAir && player_doubleJump) {
					player_y = player_2ndJumpHeight;
					player_doubleJumpReady = false;
					player_inAir = false;
					jumpChannel = j1.play(0,1);
					jumpChannel.soundTransform = new SoundTransform(0.2, 0.0);
				}
			} else {
				jumping = false;
				if (player_inAir) {
					player_doubleJumpReady = true;
				}
			}


			if (jumping && downBumping) {
				player.gotoAndPlay(145);
			} else if (player_inAir && !downBumping && player.currentFrame == 192) {
				player.stop();
			} else if (player.currentFrame > 144 && downBumping) {
				if ((leftPressed || rightPressed)) {
					player.gotoAndPlay(65);
					movingB = false;
				} else {
					player.gotoAndPlay(1);
					movingB = true;
				}
			} else if (player.currentFrame > 64 && !(leftPressed || rightPressed) && downBumping) {
				player.gotoAndPlay(1);
				movingB = true;
			} else if (player.currentFrame <= 64 && movingB && (leftPressed || rightPressed) && downBumping) {
				player.gotoAndPlay(65);
				movingB = false;
			} else if (player.currentFrame == 144 && !movingB && (leftPressed || rightPressed) && downBumping) {
				player.gotoAndPlay(65);
			}


			if (player_sideScrollingMode) {
				if (player.x < (Main.getStage().stageWidth / 2)) {
					player.x += player_xRight;
					player.y += player_y;
					player.x -= player_xLeft;

				} else {
					if (hills.x >= 0 && leftTurn && player.x <= 605) {
						player.x += player_xRight;
						player.x -= player_xLeft;
						player.y += player_y;
					} else {

						collisions.x -= player_xRight;
						collisions.x += player_xLeft;
						player.y += player_y;
						hills.x -= player_xRight / 5;
						hills.x += player_xLeft / 5;
						hills2.x -= player_xRight / 4;
						hills2.x += player_xLeft / 4;
						hills3.x -= player_xRight / 3;
						hills3.x += player_xLeft / 3;
						hills4.x -= player_xRight / 2;
						hills4.x += player_xLeft / 2;
					}
				}
			} else {
				player.x += player_xRight;
				player.x -= player_xLeft;
			}
			coins_txt.coins_txt.text = Main.coinCount + "/10"  ;
		}

		function failScreen(){
			Main.getStage().removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			Main.getStage().removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			sndBGMusicChannel = f1.play();
			//sndBGMusicChannel.soundTransform = new SoundTransform(0.5, 0.0)
			var timer: Timer = new Timer(3000);
			var failScene: fail = new fail;
			
			Main.getStage().addChild(failScene);
			var afterWaiting: Function = function (event: TimerEvent): void {
				timer.removeEventListener(TimerEvent.TIMER, afterWaiting);
				timer = null;
				Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, go);
				
			}
			timer.addEventListener(TimerEvent.TIMER, afterWaiting);
			timer.start();
			var go:Function = function(event:KeyboardEvent){
				if(event.keyCode==13){
					Main.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, go);
					sndBGMusicChannel.stop();
					sndBGMusicChannel = t1.play();
					//sndBGMusicChannel.soundTransform = new SoundTransform(0.5, 0.0)
					Main.getStage().removeChild(failScene);
					restartGame();
				}
			}
		}

		function restartGame() {
			downBumping, leftBumping, upBumping, rightBumping, underBumping, jumpBumping = false;

		leftPressed, rightPressed, upPressed, downPressed, spacePressed, shiftPressed = false;
			player.x = 100;
			player.y = Main.getStage().stageHeight - 100;

			collisions.x = 0;

			collisions.y = Main.getStage().stageHeight;

			//sky.x = stage.stageWidth/2;

			//sky.y = stage.stageHeight/1.5;

			hills.x = 0;
			hills.y = Main.getStage().stageHeight;
			hills2.x = 0;
			hills2.y = Main.getStage().stageHeight;
			hills3.x = 0;
			hills3.y = Main.getStage().stageHeight;
			hills4.x = 0;
			hills4.y = Main.getStage().stageHeight;
			Main.getStage().addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			Main.getStage().addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		function successGame() {
			Main.getStage().removeChild(coins_txt);
			
			Main.getStage().stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			Main.getStage().stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.getStage().stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			jumpChannel = s1.play(0, 1);
			jumpChannel.soundTransform = new SoundTransform(0.5, 0.0);
			var st: successText = new successText;
			Main.getStage().addChild(st);

			var timer: Timer = new Timer(4000);

			var afterWaiting: Function = function (event: TimerEvent): void {
				timer.removeEventListener(TimerEvent.TIMER, afterWaiting);
				timer = null;
				
				Main.getStage().removeChild(st);
				Main.getStage().removeChild(player);
				Main.getStage().removeChild(collisions);
				Main.getStage().removeChild(hills);
				Main.getStage().removeChild(hills2);
				Main.getStage().removeChild(hills3);
				Main.getStage().removeChild(hills4);
				var timer2: Timer = new Timer(100);

				var afterWaiting2: Function = function (event: TimerEvent): void {
					timer2.removeEventListener(TimerEvent.TIMER, afterWaiting2);
					timer2 = null;
					
					
					var e2:thirdEnd = new thirdEnd;
					Main.getStage().addChild(e2);
	
					var timer3: Timer = new Timer(4000);

					var afterWaiting3: Function = function (event: TimerEvent): void {
						timer3.removeEventListener(TimerEvent.TIMER, afterWaiting3);
						timer3 = null;
						var nextStage:Function = function(e:KeyboardEvent){
							if(e.keyCode != 13) return;
							Main.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, nextStage);
							Main.getStage().removeChild(e2);
							sndBGMusicChannel.stop();
							Main.coinCount = 0;
							var white4: whiteBG3 = new whiteBG3;
							Main.getStage().addChild(white4);
				

							var timer6: Timer = new Timer(5000);
							var afterWaiting6: Function = function (event: TimerEvent): void {
								timer6.removeEventListener(TimerEvent.TIMER, afterWaiting6);
								timer6 = null;
								
								Main.getStage().removeChild(white4);
								var tt:Main4 = new Main4();
								
							}
							timer6.addEventListener(TimerEvent.TIMER, afterWaiting6);
							timer6.start();
							
						}
						Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, nextStage);
						
						

					}
					timer3.addEventListener(TimerEvent.TIMER, afterWaiting3);
					timer3.start();
				}
				timer2.addEventListener(TimerEvent.TIMER, afterWaiting2);
				timer2.start();

			}
			timer.addEventListener(TimerEvent.TIMER, afterWaiting);
			timer.start();


		}
		
		function dialogue(a:Array){
			
			Main.getStage().removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Main.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			Main.getStage().addChild(t2);
			t2.gotoAndPlay(60);
			t2.DialogueBox.text = a.pop().toString();
			var conversation:Function = function(e:KeyboardEvent){
				jumpChannel = b1.play();
				if(a.length==0){
					Main.getStage().removeEventListener(KeyboardEvent.KEY_DOWN, conversation);
					t2.gotoAndPlay(1);
					t2.DialogueBox.text = "";
					Main.getStage().addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
					Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
					Main.getStage().removeChild(t2);
				}
				else t2.DialogueBox.text = a.pop().toString();
				
			}
			Main.getStage().addEventListener(KeyboardEvent.KEY_DOWN, conversation);
			
		}

		function keyUpHandler(e: KeyboardEvent) {

			switch (e.keyCode) {

				case 65:

					leftPressed = false;

					break;

				case 37:

					leftPressed = false;

					break;

				case 87:

					upPressed = false;

					break;

				case 38:

					upPressed = false;

					break;

				case 39:

					rightPressed = false;

					break;

				case 68:

					rightPressed = false;

					break;

				case 83:

					downPressed = false;

					break;

				case 40:

					downPressed = false;

					break;

				case 32:

					spacePressed = false;
					held = true;
					break;

			}

		}



		function keyDownHandler(event: KeyboardEvent): void {

			switch (event.keyCode) {

				case 65:

					leftPressed = true;

					break;

				case 37:

					leftPressed = true;

					break;

				case 87:

					upPressed = true;

					break;

				case 38:

					upPressed = true;

					break;

				case 39:

					rightPressed = true;

					break;

				case 68:

					rightPressed = true;

					break;

				case 83:

					downPressed = true;

					break;

				case 40:

					downPressed = true;

					break;

				case 32:

					spacePressed = true;
					if (held) {
						scaleIt += 0.1;
						held = false;
					}
					break;
			}
		}
	}
}