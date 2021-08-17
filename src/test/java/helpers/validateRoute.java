package helpers;

import java.util.List;
import java.util.stream.Collectors;

import com.google.protobuf.InvalidProtocolBufferException;
import com.haud.bifrost.protobuf.RouteOuterClass.Routes;
import com.haud.bifrost.protobuf.RouteOuterClass.Routes.Country;
import com.haud.bifrost.protobuf.RouteOuterClass.Routes.Network;
import com.haud.bifrost.protobuf.RouteOuterClass.Routes.Route;

import net.minidev.json.JSONArray;

public class validateRoute {
	
    public static JSONArray getRouteId(byte[] bs){
    	JSONArray routeIds = new JSONArray();
        try {
            Routes routes=Routes.parseFrom(bs);
            List<Route> entities=routes.getAllRoutePlansList();
            List<String> routeList = entities.stream().map(Route -> Route.getRouteId()).collect(Collectors.toList());
            routeIds.addAll(routeList);
        } catch (InvalidProtocolBufferException e) {
            e.printStackTrace();
        }
        return routeIds;
    }

    public static JSONArray getCountryId(byte[] bs,String routeId){
    	JSONArray countryId = new JSONArray();
        try {
            Routes routes=Routes.parseFrom(bs);
            for(Route route:routes.getAllRoutePlansList()) {
            	List<Country> countries=route.getCountriesList();
            	
            	if(route.getRouteId().equals(routeId)) {
            		List<String> countryIds = countries.stream().map(Country -> Country.getCountryId()).collect(Collectors.toList());
            		countryId.addAll(countryIds);
            		break;
            	}
            }
            
        } catch (InvalidProtocolBufferException e) {
            e.printStackTrace();
        }
        return countryId;
    }
    
    
    public static JSONArray getNetworkId(byte[] bs,String routeId, String CountryId){
    	JSONArray networkIds = new JSONArray();
        try {
            Routes routes=Routes.parseFrom(bs);
            for(Route route:routes.getAllRoutePlansList()) {
            	if(route.getRouteId().equals(routeId)) {
            		for(Country countr:route.getCountriesList()) {
            			if(countr.getCountryId().equals(CountryId)) {
            				List<Network> networks=countr.getCountryNetworksList();
            				List<String> networklist = networks.stream().map(Network -> Network.getNetworkId()).collect(Collectors.toList());
            				networkIds.addAll(networklist);
            				break;
            			}
            		}
            	}
            }
            
        } catch (InvalidProtocolBufferException e) {
            e.printStackTrace();
        }
        return networkIds;
    }

}
