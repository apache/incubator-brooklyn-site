/* Add the 'active' class to the correct navbar item (<li>) according to the
   global 'topLevelNav' variable defined by each page.
 */

$(function() {
    $('#topNav a').each(function(i) {
        var $this = $(this);
        if (topLevelNav == $this.text())
            $this.parent().addClass('active');
        else
            $this.parent().removeClass('active');
    });
});

