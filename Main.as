package {



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

	public class Main extends MovieClip {

		//importing swf:
		var sndBGMusicChannel: SoundChannel = new SoundChannel();
		var St1: SoundTransform = new SoundTransform();
		var jumpChannel:SoundChannel = new SoundChannel();
		var j1:jumpSFX = new jumpSFX();
		var s1:FX = new FX();
		var f1:FSBGM = new FSBGM();
		var t1:gameplay = new gameplay;
		var white:whiteBG = new whiteBG();
		
		var myLoader: Loader = new Loader(); // create a new instance of the Loader class
		var title_bg: title_screen = new title_screen;

		//	importing movieclips:
		var coins_txt:coins_mc = new coins_mc;
		var player: player_mc = new player_mc;
		var collisions: collisions_mc = new collisions_mc;
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
		var player_bounce: Boolean = true; //	Determinds whether player will bounce off the walls like a ball
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


		var coinCount:int = 0;

		public function Main() {
			stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			//createGame();
			
			titleScreen();
			
		}




		function titleScreen() {
			var St: SoundTransform = new SoundTransform();

			var url: URLRequest = new URLRequest("title screen.swf");
			var b1: cfmBT = new cfmBT;
			var open: Boolean = false;
			var b14: Scene1to4BGM = new Scene1to4BGM;
			myLoader.load(url); // load the SWF file
			addChild(myLoader);
			var t2: topbottom = new topbottom;
			var t1: titlebgm = new titlebgm;
			var sndBGMusicChannel: SoundChannel = new SoundChannel();
			var sndBGMusicChannel2: SoundChannel = new SoundChannel();
			var sndBGMusicChannel23: SoundChannel = new SoundChannel();
			sndBGMusicChannel = t1.play();
			var fadeSound: Function = function (event: Event): void {
				var vol = sndBGMusicChannel.soundTransform.volume;
				if (vol >= 0) {
					vol -= 0.0005;
					//play around with this value to control fade-out-speed
					sndBGMusicChannel.soundTransform = new SoundTransform(vol, 0.0);
				} else {
					stage.removeEventListener(Event.ENTER_FRAME, fadeSound);
					sndBGMusicChannel.stop();
				}
			}
			var fadeSound2: Function = function (event: Event): void {
				var vol = sndBGMusicChannel23.soundTransform.volume;
				if (vol >= 0) {
					vol -= 0.0005;
					//play around with this value to control fade-out-speed
					sndBGMusicChannel23.soundTransform = new SoundTransform(vol, 0.0);
				} else {
					stage.removeEventListener(Event.ENTER_FRAME, fadeSound2);
					sndBGMusicChannel23.stop();
				}
			}

			var timer: Timer = new Timer(4500);

			var afterWaiting: Function = function (event: TimerEvent): void {
				timer.removeEventListener(TimerEvent.TIMER, afterWaiting);
				timer = null;
				removeChild(myLoader);

				addChild(title_bg);
				TransitionManager.start(title_bg, {
					type: Fade,
					direction: Transition.IN,
					duration: 3,
					easing: Strong.easeIn
				});

				var enterGame: Function = function (e: KeyboardEvent) {
					if (e.keyCode == 13) {

						stage.removeEventListener(KeyboardEvent.KEY_DOWN, enterGame);
						sndBGMusicChannel2 = b1.play();

						TransitionManager.start(title_bg, {
							type: Fade,
							direction: Transition.OUT,
							duration: 3,
							easing: Strong.easeOut
						});
						stage.addEventListener(Event.ENTER_FRAME, fadeSound);
						var timer: Timer = new Timer(3500);

						var afterWaiting: Function = function (event: TimerEvent): void {
							timer.removeEventListener(TimerEvent.TIMER, afterWaiting);
							timer = null;
							stage.removeEventListener(Event.ENTER_FRAME, fadeSound);
							removeChild(title_bg);

							var url1: URLRequest = new URLRequest("scene1.swf");
							var myLoader1: Loader = new Loader();
							myLoader1.load(url1);
							// load the SWF file

							var timer2: Timer = new Timer(7000);

							var afterWaiting2: Function = function (event: TimerEvent): void {
								timer2.removeEventListener(TimerEvent.TIMER, afterWaiting2);
								timer2 = null;

								removeChild(myLoader1);
								var timer3: Timer = new Timer(5000);
								var myLoader2: Loader = new Loader();
								var url2: URLRequest = new URLRequest("second scene.swf");
								myLoader2.load(url2); // load the SWF file



								var afterWaiting3: Function = function (event: TimerEvent): void {
									trace(open);
									timer3.removeEventListener(TimerEvent.TIMER, afterWaiting3);
									timer3 = null;
									removeChild(myLoader2);
									var timer4: Timer = new Timer(22000);

									var url3: URLRequest = new URLRequest("scene3.swf");
									myLoader.load(url3); // load the SWF file



									var afterWaiting4: Function = function (event: TimerEvent): void {
										timer4.removeEventListener(TimerEvent.TIMER, afterWaiting4);
										timer4 = null;

										removeChild(myLoader);
										var timer5: Timer = new Timer(13000);

										var url4: URLRequest = new URLRequest("scene4.swf");
										myLoader.load(url4); // load the SWF file



										var afterWaiting5: Function = function (event: TimerEvent): void {
											timer5.removeEventListener(TimerEvent.TIMER, afterWaiting5);
											timer5 = null;
											stage.addEventListener(Event.ENTER_FRAME, fadeSound2);
											removeChild(myLoader);
											addChild(white);
											TransitionManager.start(white, {
												type: Fade,
												direction: Transition.IN,
												duration: 3,
												easing: Strong.easeIn
											});
											
											var timer6: Timer = new Timer(3000);
											var afterWaiting6: Function = function (event: TimerEvent): void {
												timer6.removeEventListener(TimerEvent.TIMER, afterWaiting5);
												timer6 = null;
												createGame();
												removeChild(t2);
											}
											timer6.addEventListener(TimerEvent.TIMER, afterWaiting6);
											timer6.start();
										}
										addChild(myLoader);
										timer5.addEventListener(TimerEvent.TIMER, afterWaiting5);
										timer5.start();



									}
									addChild(myLoader);
									timer4.addEventListener(TimerEvent.TIMER, afterWaiting4);
									timer4.start();


								}
								addChild(myLoader2);
								timer3.addEventListener(TimerEvent.TIMER, afterWaiting3);
								timer3.start();

							}
							addChild(myLoader1);
							timer2.addEventListener(TimerEvent.TIMER, afterWaiting2);

							timer2.start();

							sndBGMusicChannel23 = b14.play();
						}

						timer.addEventListener(TimerEvent.TIMER, afterWaiting);
						timer.start();
					}
				}
				stage.addEventListener(KeyboardEvent.KEY_DOWN, enterGame);
			}
			timer.addEventListener(TimerEvent.TIMER, afterWaiting);
			timer.start();
		}





		function createGame() {

			addChild(hills);
			addChild(hills2);
			addChild(hills3);
			addChild(hills4);
			
			addChild(collisions);
			addChild(player);
			addChild(coins_txt);
			coins_txt.x = 25;
			coins_txt.y = 25;
			coins_txt.textS.text = "Collect the separated letters!"
			//player.scaleX = 0.4;
			//player.scaleY = 0.4;
			player.height *= 0.4;
			player.width *= 0.4;
			
			
			
			
			
			sndBGMusicChannel = t1.play();
			
			//sndBGMusicChannel.soundTransform = new SoundTransform(0.5, 0.0);
			
			player.x = 100;
			player.y = stage.stageHeight - 100;

			collisions.x = 0;

			collisions.y = stage.stageHeight;

			//sky.x = stage.stageWidth/2;

			//sky.y = stage.stageHeight/1.5;

			hills.x = 0;
			hills.y = stage.stageHeight;
			hills2.x = 0;
			hills2.y = stage.stageHeight;
			hills3.x = 0;
			hills3.y = stage.stageHeight;
			hills4.x = 0;
			hills4.y = stage.stageHeight;

			collisions.visible = true;
			collisions.ground.visible = false;
			

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}



		function removeGame() {
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

			removeChild(hills);
			removeChild(collisions);
			removeChild(player);
		}



		function onEnterFrameHandler(e: Event) {
			if ((collisions.ground.hitTestPoint(player.x + player.width * 0.8 / 6, player.y, true)) ||
				(collisions.ground.hitTestPoint(player.x - player.width * 0.8 / 6, player.y, true)) ||
				(collisions.ground.hitTestPoint(player.x, player.y, true))) {
				downBumping = true;
			} else {
				downBumping = false;
			}

			if (collisions.ground.hitTestPoint(player.x, player.y + 7, true)) {
				jumpBumping = true;
			} else {
				jumpBumping = false;
			}

			if (collisions.ground.hitTestPoint(player.x, player.y - 2, true)) {
				underBumping = true;
			} else {
				underBumping = false;
			}

			if ((collisions.ground.hitTestPoint(player.x - player.width * 0.8 / 2, player.y - player.height * 0.8 / 2, true)) ||
				(collisions.ground.hitTestPoint(player.x - player.width * 0.8 / 2, player.y - player.height * 0.9, true)) ||
				(collisions.ground.hitTestPoint(player.x - player.width * 0.8 / 2, player.y - 2, true))) {
				leftBumping = true;
			} else {
				leftBumping = false;
			}
			
			if ((collisions.touch_mc.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.8 / 2, true)) ||
				(collisions.touch_mc.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.9, true)) ||
				(collisions.touch_mc.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - 2, true))) {
				if(coinCount == 6){
					successGame();
				}
				
			}
			
			
			if ((collisions.ground.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.8 / 2, true)) ||
				(collisions.ground.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - player.height * 0.9, true)) ||
				(collisions.ground.hitTestPoint(player.x + player.width * 0.8 / 2, player.y - 2, true))) {
				rightBumping = true;
			} else {
				rightBumping = false;
			}

			if (collisions.ground.hitTestPoint(player.x, player.y - player.height * 0.8, true)) {
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
				if (player.x < (stage.stageWidth / 2)) {
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
			coins_txt.coins_txt.text = "Letters collected : " + coinCount;
		}

		function failScreen(){
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			sndBGMusicChannel = f1.play();
			//sndBGMusicChannel.soundTransform = new SoundTransform(0.5, 0.0)
			var timer: Timer = new Timer(3000);
			var url1: URLRequest = new URLRequest("failed scene.swf");
							var myLoader1: Loader = new Loader();
							myLoader1.load(url1);
			addChild(myLoader1);
			var afterWaiting: Function = function (event: TimerEvent): void {
				timer.removeEventListener(TimerEvent.TIMER, afterWaiting);
				timer = null;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, go);
				
			}
			timer.addEventListener(TimerEvent.TIMER, afterWaiting);
			timer.start();
			var go:Function = function(event:KeyboardEvent){
				if(event.keyCode==13){
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, go);
					sndBGMusicChannel.stop();
					sndBGMusicChannel = t1.play();
					//sndBGMusicChannel.soundTransform = new SoundTransform(0.5, 0.0)
					removeChild(myLoader1);
					restartGame();
				}
			}
		}

		function restartGame() {
			player.x = 100;
			player.y = stage.stageHeight - 100;

			collisions.x = 0;

			collisions.y = stage.stageHeight;

			//sky.x = stage.stageWidth/2;

			//sky.y = stage.stageHeight/1.5;

			hills.x = 0;
			hills.y = stage.stageHeight;
			hills2.x = 0;
			hills2.y = stage.stageHeight;
			hills3.x = 0;
			hills3.y = stage.stageHeight;
			hills4.x = 0;
			hills4.y = stage.stageHeight;
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}

		function successGame() {
			removeChild(coins_txt);
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			jumpChannel = s1.play(0,1);
			jumpChannel.soundTransform = new SoundTransform(0.5, 0.0);
			var st:successText = new successText;
			addChild(st);
			
			var timer:Timer = new Timer(4000);
			
			var afterWaiting: Function = function (event: TimerEvent): void {
				timer.removeEventListener(TimerEvent.TIMER, afterWaiting);
				timer = null;
				removeChild(hills);
			removeChild(collisions);
			removeChild(player);
				addChild(white);
				TransitionManager.start(white, {
							type: Fade,
							direction: Transition.OUT,
							duration: 4,
							easing: Strong.easeOut
				});
				var timer2:Timer = new Timer(2000);
				
				var afterWaiting2: Function = function (event: TimerEvent): void {
					timer2.removeEventListener(TimerEvent.TIMER, afterWaiting2);
					timer2 = null;
					removeChild(white);
					var myLoader2: Loader = new Loader();
					var url2: URLRequest = new URLRequest("end-level_Kindness_new.swf");
					myLoader2.load(url2);
					
					addChild(myLoader2);
				}
				timer2.addEventListener(TimerEvent.TIMER, afterWaiting2);
				timer2.start();
				
			}
			timer.addEventListener(TimerEvent.TIMER, afterWaiting);
			timer.start();
				
			
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