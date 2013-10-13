/**
 * Created with JetBrains RubyMine.
 * User: SHM
 * Date: 14.10.13
 * Time: 1:09
 * To change this template use File | Settings | File Templates.
 */
$(function(){
   $("#multiselect").change( function() {
       var selected = "";
       $("#multiselect option:selected").each(function() {
           selected += $( this ).text() + ", "
       })
       console.log(selected.substring(0, selected.length - 2))
      })
})