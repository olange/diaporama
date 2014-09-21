import java.net.SocketException;
import artnet4j.ArtNetException;
import artnet4j.ArtNetServer;
import artnet4j.events.ArtNetServerListener;
import artnet4j.packets.ArtDmxPacket;
import artnet4j.packets.ArtNetPacket;

class ArtNetListener {
  public static final int DMX_CHANNELS_COUNT = 512;

  private static final int SUBNET_COUNT = 16;
  private static final int UNIVERSE_COUNT = 16;

  private int inPort = ArtNetServer.DEFAULT_PORT;
  private int outPort = ArtNetServer.DEFAULT_PORT;
  private String broadcastAddress = ArtNetServer.DEFAULT_BROADCAST_IP;
  private int currentSubnet;
  private int currentUniverse;
  private int sequenceId;

  private byte[][][] inputDmxArrays = new byte[ SUBNET_COUNT][ UNIVERSE_COUNT][ DMX_CHANNELS_COUNT];
  private boolean[][][] inputDmxTriggered = new boolean[ SUBNET_COUNT][ UNIVERSE_COUNT][ DMX_CHANNELS_COUNT];
  private boolean[][][] inputDmxLeveledUp = new boolean[ SUBNET_COUNT][ UNIVERSE_COUNT][ DMX_CHANNELS_COUNT];

  private ArtNetServer artNetServer = null;

  ArtNetListener( final int currSubnet, final int currUniverse) {
    this.currentSubnet = currSubnet;
    this.currentUniverse = currUniverse;
    this.sequenceId = 0;
    try {
      startArtNet();
    } catch( SocketException e) {
      println( e);
    } catch( ArtNetException e) {
      println( e);
    }
  }
  
  public void startArtNet()
    throws SocketException, ArtNetException {

    if( this.artNetServer == null) {
      this.artNetServer = new ArtNetServer( this.inPort, this.outPort);
      this.artNetServer.setBroadcastAddress( this.broadcastAddress);
      this.artNetServer.start();
      initArtNetReceiver();
      println( "ArtNet Started (broadcast: " + this.broadcastAddress
             + ", in: " + this.inPort + ", out: " + this.outPort + ")");
    }
  }

  public void stopArtNet() {
    if( this.artNetServer != null) {
        this.artNetServer.stop();
        this.artNetServer = null;
        println( "ArtNet Stopped");
    }
  }

  public void restartArtNet()
    throws SocketException, ArtNetException {
    stopArtNet();
    startArtNet();
  }

  private void initArtNetReceiver() {
    this.artNetServer.addListener(
      new ArtNetServerListener() {
        @Override
        public void artNetPacketReceived( final ArtNetPacket artNetPacket) {
          switch( artNetPacket.getType()) {
            case ART_OUTPUT:
              ArtDmxPacket artDmxPacket = (ArtDmxPacket) artNetPacket;
              int subnet = artDmxPacket.getSubnetID();
              int universe = artDmxPacket.getUniverseID();
              int numChannels = artDmxPacket.getNumChannels(); 
              System.arraycopy(
                artDmxPacket.getDmxData(), 0,
                inputDmxArrays[ subnet][ universe], 0,
                numChannels);
              break;

            default:
              break;
          }
        }

        @Override
        public void artNetServerStopped( final ArtNetServer artNetServer) {
        }

        @Override
        public void artNetServerStarted( final ArtNetServer artNetServer) {
        }

        @Override
        public void artNetPacketUnicasted( final ArtNetPacket artNetPacket) {
        }

        @Override
        public void artNetPacketBroadcasted( final ArtNetPacket artNetPacket) {
        }
    });
  }

  public void watchTriggers( final int subnet, final int universe,
                             final int numChannels) {
    Integer level;
    boolean leveledUp;
    boolean triggered;
    for( int i = 0; i < numChannels; i++) {
      level = getValueAt( subnet, universe, i);
      leveledUp = leveledUpAt( subnet, universe, i);
      if( leveledUp &&( level < 64)) {
        leveledUp = false;
        triggered = true;
      }
      else if( !leveledUp &&( level > 192)) {
        leveledUp = true;
        triggered = true;
      }
      else triggered = false;
      inputDmxLeveledUp[ subnet][ universe][ i] = leveledUp;
      inputDmxTriggered[ subnet][ universe][ i] = triggered; 
    }
  }
  
  public void watchTriggers( final int numChannels) {
    watchTriggers( this.currentSubnet, this.currentUniverse, numChannels);
  }

  public Integer toInt( Byte dmxChannelValue) {
    int intValue = dmxChannelValue.intValue();
    return intValue < 0 ? intValue + 256 : intValue;
  }
  
  public Boolean leveledUpAt( final int subnet, final int universe, final int index) {
    return inputDmxLeveledUp[ subnet][ universe][ index];
  }

  public Boolean leveledUpAt( final int index) {
    return leveledUpAt( this.currentSubnet, this.currentUniverse, index);
  }

  public Boolean triggeredAt( final int subnet, final int universe, final int index) {
    return inputDmxTriggered[ subnet][ universe][ index];
  }

  public Boolean triggeredAt( final int index) {
    return triggeredAt( this.currentSubnet, this.currentUniverse, index);
  }

  public Integer getValueAt( final int subnet, final int universe, final int index) {
    return toInt( (Byte)inputDmxArrays[ subnet][ universe][ index]);
  }

  public Integer getValueAt( final int index) {
    return getValueAt( this.currentSubnet, this.currentUniverse, index);
  }
  
  public byte[] getCurrentInputDmxArray( final int subnet, final int universe) {
    return inputDmxArrays[ subnet][ universe];
  }
  
  public byte[] getCurrentInputDmxArray() {
    return getCurrentInputDmxArray( this.currentSubnet, this.currentUniverse);
  }
}
