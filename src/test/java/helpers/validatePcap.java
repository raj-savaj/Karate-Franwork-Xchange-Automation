package helpers;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import config.configApplication;

public class validatePcap {

    private JSch jsch;
    private Session session;
    private Channel channel;
    private Thread thread = null;

    private static String ssh_ip= configApplication.getGlobalValue("ipAddress");
    private static String ssh_username= configApplication.getGlobalValue("sshUsername");
    private static String ssh_password= configApplication.getGlobalValue("sshPassword");

    public validatePcap(){
        jsch = new JSch();
        try {
            System.out.println("PcapValidation class loaded");
            session = jsch.getSession(ssh_username, ssh_ip ,22);
            session.setPassword(ssh_password);
            session.setConfig("StrictHostKeyChecking", "no");
        } catch (JSchException e) {
            e.printStackTrace();
        }
       
    }
    
    public void startPcapWriting(String filename) {
        System.out.println("startPcapWriting method running.");
    	thread = new Thread(new Runnable() {
			public void run() {
				connectChanel(filename);
			}
		});
		thread.start();
    }
    
    public String readPcapFile(String filename, String filter){
        StringBuilder str = new StringBuilder();
        try {
            jsch = new JSch();
            session = jsch.getSession(ssh_username, ssh_ip ,22);
            session.setPassword(ssh_password);
            session.setConfig("StrictHostKeyChecking", "no");

            session.connect();
            channel=session.openChannel("exec");
            ((ChannelExec) channel).setPty(true);
            ((ChannelExec)channel).setCommand("tshark -r " + filename + " -Y " + filter);
            channel.setInputStream(null);
            ((ChannelExec)channel).setErrStream(System.err);
            InputStream in=channel.getInputStream();
            channel.connect();
            byte[] tmp=new byte[1024];
            while(true){
                while(in.available()>0){
                    int i=in.read(tmp, 0, 1024);
                    if(i<0)break;
                    str.append(new String(tmp, 0, i));
                }
                if(channel.isClosed()){
                    break;
                }
            }
        } catch (JSchException  | IOException e) {
            e.printStackTrace();
        }
        return str.toString();
    }

    public void stopPcapWriting() {
        System.out.println("stopPcapWriting method running.");
    	if (thread != null) {
    		closeChannel();
			thread.interrupt();
			System.out.println("Thread successfully stopped.");
		}
    }
    
    public void connectChanel(String filename){
        try {
            session.connect();
            channel=session.openChannel("exec");
            ((ChannelExec) channel).setPty(true);
            ((ChannelExec)channel).setCommand("sudo -S -p '' tcpdump -i any -w "+filename);
            ((ChannelExec)channel).setErrStream(System.err);
            OutputStream out=channel.getOutputStream();
            channel.connect();
            out.write(String.format("%s\n", ssh_password).getBytes());
            out.flush();
            System.out.println("Thread successfully started.");
        } catch (JSchException  | IOException e) {
            e.printStackTrace();
        }
    }

    public void closeChannel(){
        if(channel!=null && session!=null){
            try {
                channel.sendSignal("2");
                System.out.println("redis_stop_log");
                channel.disconnect();
                session.disconnect();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
