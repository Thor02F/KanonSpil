class life1{

void display(){
 rect(0,0,width/2,height/6);
 fill(227,34,39);
}

}

class life2{
  
void display(){
 rect(width/2,0,width/2,height/6);
 fill(65,105,225);
}

}

life1 lifep1;
life2 lifep2;

void setup(){
 size(500,500); 
 lifep1 = new life1();
 lifep2 = new life2();
}

void draw(){
  lifep1.display();
  lifep2.display();
}
