# Geoserver & GeoMesa BigTable
Docker image running Geoserver with GeoMesa BigTable.

## Usage
1. Build and run image
```
docker image build -t geoserver .
docker run -d -p 8080:8080 geoserver
```
2. Access at http://localhost:8080/geoserver
