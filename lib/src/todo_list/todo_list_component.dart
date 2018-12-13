import 'dart:async';
import 'dart:math';
import 'dart:html';
import 'package:http/http.dart' as http;


import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'students.dart';
import 'todo_list_service.dart';

@Component(
  selector: 'todo-list',
  styleUrls: ['todo_list_component.css'],
  templateUrl: 'todo_list_component.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    MaterialButtonComponent,
    MaterialTabComponent,
    NgFor,
    NgIf,
  ],
  providers: [const ClassProvider(TodoListService)],
)


class TodoListComponent implements OnInit {

var names=[students("陈瑶", 0),students("朱子恒", 0),students("周嘉翔", 0),students("唐莉雯", 0),students("张静雅", 0),students("龙晶毅", 0),students("朱鹏伟", 0),students("戚晓颖", 0),students("郑可欣", 0),students("李典康", 0),students("吴松二", 0),students("蔡心蕊", 0),students("赵世宇", 0)];

  @override
  Future<Null> ngOnInit() async {

  }

  void add() {
    var random=Random();
    var number=random.nextInt(13);
   
    querySelector('#tips').text='请'+names[number].name+"同学回答！";  
    names[number].times++;
  }

  void addLeast(){
    num min=0;

    for(var i=0;i<13;i++){
      if(names[min].times>names[i].times) min=i;
    }

    querySelector('#tips').text='请'+names[min].name+"同学回答！";  
    names[min].times++; 
  }
}