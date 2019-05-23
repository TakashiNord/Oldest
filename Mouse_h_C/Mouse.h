
/*************************************************************/
/* file : mouse.h                                                                                              */
/*Copyright,2001 ,Borland International                                                     */
/************************Mouse service*************************/

 #include <dos.h>
 #include <bios.h>

 #define ON  1
 #define OFF 2

 int dec_=10;
 int X_MIN,X_MAX,Y_MIN,Y_MAX,MOUSE_READY=0;

 int mouse_status(void)
 /*Функция возвращает количество кнопок у мыши и 
  устанавливает готова -ли к работе */
 { union REGS inr,outr;
   inr.x.ax=0;int86(0x33,&inr,&outr);
   MOUSE_READY=((signed int)outr.x.ax==-1)?1:0;
   return(outr.x.bx);
   }

 int mouse_show(int show)
 /*Функция показывает или прячет курсор мыши на экране */
 { union REGS inr,outr;int i=0;
   if (show==ON) {inr.x.ax=show;int86(0x33,&inr,&outr);i=0;}
    else if (show==OFF) { inr.x.ax=show;int86(0x33,&inr,&outr);i=0;}
	   else i=-1;
   return(i);
  }

  int mouse_screen_size(int x_min,int y_min,int x_max,int y_max)
 /*Функция устанавливает размеры окна на экране , по которому может 
 перемещаться курсор мыши. */
 { union REGS inr,outr;
   inr.x.ax=7;inr.x.cx=x_min;inr.x.dx=x_max; int86(0x33,&inr,&outr);
   X_MIN=(x_min<x_max)?x_min:x_max;X_MAX=(x_min>x_max)?x_min:x_max;
   inr.x.ax=8;inr.x.cx=y_min;inr.x.dx=y_max; int86(0x33,&inr,&outr);
    X_MIN=(y_min<y_max)?y_min:y_max;X_MAX=(y_min>y_max)?y_min:y_max;
   return(0);
   }

 int position_status(int &Status,int &Xcoord,int &Ycoord)
 /*Функция записывает координаты курсора мыши и состояние кнопок */
 { union REGS inr,outr;
   inr.x.ax=3;int86(0x33,&inr,&outr);
   Xcoord=outr.x.cx;Ycoord=outr.x.dx;Status=outr.x.bx;
    return(0);
   }

 int set_position(int x,int y)
 /*Функция устанавливает курсор мыши в указанную точку экрана */
 { union REGS inr,outr;
   inr.x.ax=4;inr.x.cx=x;inr.x.dx=y;int86(0x33,&inr,&outr);
   return(0);
  }

 int mouse_speed(int horizontal,int vertical)
 /*Функция устанавливает относительную скорость перемещения курсора мыши по экрану.
  Стандартная установка :8 шагов по горизонтали,16 по вертикали . */
 { union REGS inr,outr;
   inr.x.ax=15;inr.x.cx= horizontal;inr.x.dx=vertical;int86(0x33,&inr,&outr);
   return(0);
  }

 int get_key(int &status,int &x,int &y)
 /*Функция  симулирует перемещение мыши ; если нажата клавиша расширенной клавиатуры
,и записывает новые координаты курсора. Симулирует статус нажатия кнопок мыши при нажатии клавиши
 Enter,Esc,SpaceBar.При нажатии других клавиш в Status записывается их расширенный ASCII - код. */
 { int buf=bioskey(0);
   if ((buf&0x0ff)==0)
     switch((buf>>8)&0x0ff)
      { case 71:/*home*/ x-=dec_;y-=dec_;break;
	 case 72:/*Up*/ y-=dec_;break;
	 case 73:/*PgUp*/ x+=dec_;y-=dec_;break;
	 case 75:/*Left*/ x-=dec_;break;
	 case 77:/*Right*/ x+=dec_;break;
	 case 79:/*End*/ x-=dec_;y+=dec_;break;
	 case 80:/*Down*/ y+=dec_;break;
	 case 81:/*PgDn*/ x+=dec_;y+=dec_;break;
	 default: status=buf; }
      else  switch((buf & 0x0ff))
      { case 43:/*+*/ if(dec_<30) dec_+=1;break;
	 case 45:/*-*/ if(dec_>1) dec_-=1;break;
	 case 27:/*Esc*/ status=2;break;
	 case 13:/*Enter*/  status=1;break;
	 case 32:/*SpaceBar*/  status=4;break;
	   default: status=buf; }
  if (x<X_MIN) x=X_MIN; if (y<Y_MIN) y=Y_MIN;
  if (x>X_MAX) x=X_MAX; if (y>Y_MAX) y=Y_MAX;
  return(0);
  }

 int mouse_key_status(int &status,int &x,int &y)
 /*Функция записывает координаты курсора мыши и состояние ее кнопок.
  При нажатии других клавиш в Status записывается их расширенный ASCII - код. */
 { int i=0;
   if (MOUSE_READY) position_status(status,x,y);
   while(0!=status) {i=status; if (MOUSE_READY) position_status(status,x,y);}
   status=i; 
 if ((0!=bioskey(1)) && (0==status)) { get_key(status,x,y); if (MOUSE_READY) set_position(x,y);}
  return(0);
  }

/****************************end of service**********************************/