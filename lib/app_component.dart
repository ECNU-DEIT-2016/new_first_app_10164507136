import 'package:angular/angular.dart';

import 'src/todo_list/todo_list_component.dart';
import 'src/hero_form/hero_form_component.dart';


// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
 // template: '<hero-form></hero-form>',
  templateUrl: 'app_component.html',
  directives: [TodoListComponent,
  HeroFormComponent],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
