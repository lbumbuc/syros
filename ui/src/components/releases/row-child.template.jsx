export default function(h, row) {
    if (row.log.length < 1){
        row.log = 'LOG'
    }
   return (
    <div class="row">
        <pre>{row.log}</pre>
    </div>
   )
}