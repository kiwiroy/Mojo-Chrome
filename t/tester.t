use Mojolicious::Lite;

any '/' => 'main';

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->with_roles('+Chrome')->new;

$t->chrome_load_ok('/')
  ->chrome_evaluate_ok(q!document.getElementsByTagName('p')[0].innerHTML!)
  ->chrome_result_is('Goodbye')
  ->chrome_result_like(qr/bye/);

done_testing;

__DATA__

@@ main.html.ep

<!DOCTYPE html>
<html>
  <head></head>
  <body>
    <p>Hello</p>
    %= javascript begin
      (function(){ document.getElementsByTagName('p')[0].innerHTML = 'Goodbye'; })();
    % end
  </body>
</html>


