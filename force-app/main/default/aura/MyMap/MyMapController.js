({
    jsLoaded: function(component, event, helper) {
        setTimeout(function() {
            var map = L.map('map', {zoomControl: true}).setView([39.212356, -76.865515], 13);
            L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);
                       
            // Add marker
            L.marker([39.212356, -76.865515]).addTo(map) 
            .bindPopup('<b>Enterprise Business Partner </b><br/> 11000 Broken Land Parkway, Columbia, MD, USA');
            
            //Move map to marker
            map.panTo([39.212356, -76.865515]);
        });
    }
})