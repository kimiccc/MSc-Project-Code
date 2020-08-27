<template>
  <v-app class="grey lighten-3">
    <v-content>
      <v-container>
        <v-layout
          text-xs-center
          wrap
        >
          <v-flex mb-4>
            <h1 class="display-2 font-weight-bold mb-3">
              Curriculum management
            </h1>
            <p class="subheading font-weight-regular">
              Utilizing Ethereum for Decentralized Curriculum Management
            </p>
          </v-flex>
        </v-layout>

        <v-layout row justify-center>
          <v-dialog v-model="addCourseDialog" max-width="600px" persistent>
            <v-btn slot="activator" color="primary" dark>Add Curriculum</v-btn>
            <v-card>
              <v-card-title>
                <span class="headline font-weight-bold mt-2 ml-4">Add curriculum to blockchain</span>
              </v-card-title>
              <v-card-text class="pt-0">
                <v-container class="pt-0" grid-list-md>
                  <v-layout wrap>
                    <v-flex xs12>
                      <v-text-field
                        label="Curriculum Id"
                        persistent-hint
                        v-model="newCourse.courseId">
                      </v-text-field>
                    </v-flex>

                    <v-flex xs12>
                      <v-text-field
                        label="Year"
                        persistent-hint
                        v-model="newCourse.year">
                      </v-text-field>
                    </v-flex>

                    <!--
                    <v-flex xs12>
                      <v-text-field
                        label="IPFS hash"
                        persistent-hint
                        v-model="newCourse.hash">
                      </v-text-field>
                    </v-flex>-->

                    <v-flex xs12>


         <input type="file" ref="inputer" id="inputFile" name="inputFile" style="display:none"  value="Choose file" @change="captureFile"/>

        <input type="button" id="loadFileXml" style="background: #ccc; padding: 3px; margin-right: 5px;" value="Choose file" onclick="document.getElementById('inputFile').click();" />
        <input type="text" value="" disabled id="inputFileAgent" />

                    </v-flex>

                  </v-layout>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  flat
                  @click="addCourseDialog = false;
                  newCourse.isLoading = false;">
                  Close
                </v-btn>
                <v-btn color="blue darken-1"
                  flat
                  @click="upload"
                  :loading="newCourse.isLoading">
                  Save
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-layout>

        <v-layout row justify-center>
          <v-dialog v-model="readCourseDialog" max-width="600px" persistent>
            <v-btn slot="activator" color="primary" dark>Read Curriculum</v-btn>
            <v-card>
              <v-card-title>
                <span class="headline font-weight-bold mt-2 ml-4">Read Curriculum</span>
              </v-card-title>
              <v-card-text class="pt-0">
                <v-container class="pt-0" grid-list-md>
                  <v-layout wrap>
                    <v-flex xs12>
                      <v-text-field
                        label="Curriculum Id"
                        persistent-hint
                        v-model="newCourse.courseId">
                      </v-text-field>
                    </v-flex>

                    <v-flex xs12>
                      <v-text-field
                        label="Year"
                        persistent-hint
                        v-model="newCourse.year">
                      </v-text-field>
                    </v-flex>



                  </v-layout>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  flat
                  @click="readCourseDialog = false;
                  newCourse.isLoading = false;">
                  Close
                </v-btn>
                <v-btn color="blue darken-1"
                  flat
                  @click="getCourses"
                  :loading="newCourse.isLoading">
                  Read
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-layout>


        <v-layout row justify-center>
          <v-dialog v-model="trasferOwnershipDialog" max-width="600px" persistent>
            <v-btn slot="activator" color="primary" dark>Transfer OwnerShip</v-btn>
            <v-card>
              <v-card-title>
                <span class="headline font-weight-bold mt-2 ml-4">Transfer OwnerShip</span>
              </v-card-title>
              <v-card-text class="pt-0">
                <v-container class="pt-0" grid-list-md>
                  <v-layout wrap>
                    <v-flex xs12>
                      <v-text-field
                        label="Ethereum Address"
                        persistent-hint
                        v-model="newAddress">
                      </v-text-field>
                    </v-flex>


                  </v-layout>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  flat
                  @click="trasferOwnershipDialog = false;
                  newCourse.isLoading = false;">
                  Close
                </v-btn>
                <v-btn color="blue darken-1"
                  flat
                  @click="trasferOwnership"
                  :loading="newCourse.isLoading">
                  Transfer
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-layout>

      </v-container>

      <v-container
        grid-list-lg
      >
        <h1 class="display-1 font-weight-bold mb-3">
          Curriculum Read
        </h1>
        <v-layout row wrap>
          <v-flex v-for="(course, index) in courseData" :key="index" xs12>
              <v-card>
                <v-card-title >
                 <span class="headline font-weight-bold">Curriculum Id:  </span> {{ course.courseId }}
                </v-card-title>
                <v-card-text>
                 <span class="headline font-weight-bold">Year:  </span> {{ course.year }}
                </v-card-text>

                <v-card-text>
                 <span class="headline font-weight-bold">IPFS Link:  </span> {{ course.hash }}
                </v-card-text>

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    flat="flat"
                    @click="openLink(index)"
                  >
                    View
                  </v-btn>
                </v-card-actions>
              </v-card>
          </v-flex>
        </v-layout>
      </v-container>

      <v-container
        grid-list-lg
      >
        <div class="search">
          <h1 class="display-1 font-weight-bold mb-3">
            Curriculums List
          </h1>
          <input type="text" placeholder="Please input Curriculum ID or year" v-model="search" @input="changeInput()" id="search-input">
        </div>
        <br/>
        <v-layout row wrap>
          <v-flex v-for="(course, index) in courseLists" :key="index" xs12 v-if="!isSearch">
              <v-card>
                <v-card-title >
                 <span class="headline font-weight-bold">Curriculum Id:  </span> {{ course.courseId }}
                </v-card-title>
                <v-card-text>
                 <span class="headline font-weight-bold">Year:  </span> {{ course.year }}
                </v-card-text>
                <v-card-text>
                 <span class="headline font-weight-bold">Time:  </span> {{ course.time }}
                </v-card-text>
                <v-card-text>
                 <span class="headline font-weight-bold">IPFS Link:  </span> {{ course.hash }}
                </v-card-text>

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    flat="flat"
                    @click="openLink2(index)"
                  >
                    View
                  </v-btn>
                </v-card-actions>
              </v-card>
          </v-flex>

          <v-flex v-for="(course, index) in courseSearchLists" :key="index" xs12 v-if="isSearch">
              <v-card>
                <v-card-title >
                 <span class="headline font-weight-bold">Curriculum Id:  </span> {{ course.courseId }}
                </v-card-title>
                <v-card-text>
                 <span class="headline font-weight-bold">Year:  </span> {{ course.year }}
                </v-card-text>

                <v-card-text>
                 <span class="headline font-weight-bold">Time:  </span> {{ course.time }}
                </v-card-text>
                
                <v-card-text>
                 <span class="headline font-weight-bold">IPFS Link:  </span> {{ course.hash }}
                </v-card-text>

                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                    color="blue darken-1"
                    flat="flat"
                    @click="openLink2(index)"
                  >
                    View
                  </v-btn>
                </v-card-actions>
              </v-card>
          </v-flex>


        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
// We import our the scripts for the smart contract instantiation, and web3
import courseInstance from '../contracts/course';
import web3 from '../contracts/web3';
//import ipfs from './util/ipfs.js'
//const IPFS = require('ipfs-http-client');
const IPFS = require('ipfs-mini');

export default {
  name: 'App',
  data() {
    return {
      addCourseDialog: false,
      readCourseDialog: false,
      trasferOwnershipDialog: false,
      account: null,
      newAddress: '',
      search: "",
      isSearch: false,
      stateMap: [
        { color: 'primary', text: 'Ongoing' },
        { color: 'warning', text: 'Expired' },
        { color: 'success', text: 'Completed' },
      ],
      courseData: [],
      courseLists: [],
      courseSearchLists: [],
      newCourse: { isLoading: false },
      formData: null,
      ipfsHash: null,
      buffer: "",
      filename: ""
    };
  },
  mounted() {

    // this code snippet takes the account (wallet) that is currently active
    if(window.ethereum) {
      web3.eth.getAccounts().then((accounts) => {
        [this.account] = accounts;
        //this.getProjects();
      });
      this.listCourse()
    }

  },
  methods: {
    changeAgentContent(){
      document.getElementById("inputFileAgent").value = document.getElementById("inputFile").value;
      var str = document.getElementById("inputFile").value;
      str = str.substring(12, str.length)
      document.getElementById("inputFileAgent").value = str
      console.log(str)
    },
    changeInput() {
      this.courseSearchLists.length = 0
      this.courseSearchLists = []
      console.log(this.courseSearchLists)


      if (this.search.length > 0) {
        this.isSearch = true
      } else {
        this.isSearch = false
      }

      var isNumber = parseInt(this.search) > 0
      //console.log(isNumber)

      var len = this.courseLists.length
      if (isNumber) {  // 过滤年份
        for (var i = 0; i < len; i++) {
          var year = this.courseLists[i].year.toString()
          if (year.match(this.search)) {
            this.courseSearchLists.push(this.courseLists[i])
          }
        }
      } else { // 过滤课程id
        for (var i = 0; i < len; i++) {
          var courseId = this.courseLists[i].courseId
          //console.log(courseId.substring(0, this.search.length))
          //if (courseId.substring(0, this.search.length) == this.search.toString()) {、
          if (this.courseLists[i].courseId.match(this.search)) {
            this.courseSearchLists.push(this.courseLists[i])
            console.log(this.courseSearchLists)
          }
        }

      }
    },
    async trasferOwnership() {
      console.log(this.newAddress)
      if (this.newAddress.length != 42) {
        return
      }

      const accounts = await web3.eth.getAccounts();
      console.log(accounts)
      
      this.newCourse.isLoading = true

      courseInstance.methods.changeOwner(this.newAddress).send({
        from: accounts[0]
      }).then((res) => {
        this.newCourse.isLoading = false
      })
    },
    async listCourse() {

      var length = await courseInstance.methods.coursesLength().call();
      console.log(length)

      if (length > 0) {
        this.courseLists.length = 0; //clear it
        console.log(this.courseLists)

        Date.prototype.toLocaleString = function() {
          return this.getFullYear() + "/" + (this.getMonth() + 1) + "/" + this.getDate() + "/ " + this.getHours() + ":" + this.getMinutes() + ":" + this.getSeconds();
        };
        
        for(var i = 0; i < length; i++) {
          courseInstance.methods.listCourse(i).call().then((result) => {
            console.log(result)
            const courseInfo = {}
            
            courseInfo.year = result[0]


            var unixTimestamp = new Date(result[1]*1000);
            courseInfo.time = unixTimestamp.toLocaleString()
            courseInfo.courseId = result[2]
            courseInfo.hash = 'https://ipfs.oceanprotocol.com/ipfs/' + result[3]
            
            this.courseLists.push(courseInfo)
          })
        }
      }

    },
    async addCourses(ipfsHash) {
      var courseId = this.newCourse.courseId
      var year = parseInt(this.newCourse.year)
      //var hash = this.newCourse.hash
      var hash = ipfsHash

      const accounts = await web3.eth.getAccounts();
      console.log(accounts)

      if (courseId == '' || year < 0) {
        return
      }

      //console.log(courseId)
      //console.log(year)
      //console.log(hash)
      this.newCourse.isLoading = true
      //console.log(courseInstance.methods)
      courseInstance.methods.setCourse(courseId, year, hash).send({from: accounts[0]}).then((res) => {
        //console.log(res)
        this.newCourse.isLoading = false
        this.addCourseDialog = false

        this.listCourse()
      })
    },
    getCourses() {
      var courseId = this.newCourse.courseId
      var year = parseInt(this.newCourse.year)

      if (courseId == '' || year < 0)  {
        return
      }


      courseInstance.methods.getCourse(courseId, year).call().then((data) => {
        console.log(data)
        const courseInfo = {}
        courseInfo.courseId = courseId
        courseInfo.year = year
        courseInfo.hash = 'https://ipfs.oceanprotocol.com/ipfs/' + data
        this.courseData.length = 0
        this.courseData.push(courseInfo)
        this.readCourseDialog = false
      })

    },
    captureFile(event) {
      this.changeAgentContent()

      event.stopPropagation();
      event.preventDefault();
      const file = event.target.files[0];
      console.log(file.name)
      this.filename = file.name
      let reader = new window.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onloadend = () => this.convertToBuffer(reader);
    },
    async convertToBuffer(reader) {
      //file is converted to a buffer for upload to IPFS
      const Bufferdata = await Buffer.from(reader.result);
      //set this buffer -using es6 syntax
      this.buffer = Bufferdata;
      //console.log("BUF " + this.buffer);
    },
    async upload() {
      event.preventDefault()
      //const ipfs = new IPFS({host:'ipfs.infura.io',port:5001,protocol:'https'});
      //const ipfs = IPFS()
      const ipfs = new IPFS({ host: 'ipfs.oceanprotocol.com', port: 443, protocol: 'https' })
      console.log(ipfs);

      /*
      const fileDetails = {
        path: this.filename,
        content: this.buffer
      }

      const options = {
        wrapWithDirectory: true
      }

      const source = ipfs.add(fileDetails, options)

      for await (const file of source) {
        console.log(file)
      }*/
      //ipfs.add(fileDetails, options).then(result => {
      //  console.log(result)
      //})

      ipfs.add(this.buffer).then(result => {
        console.log(result)
        this.addCourses(result)
      })

    },
    progressFun(progress) {
      console.log(progress)
    },
    openLink(index) { 
      window.open(this.courseData[index].hash, "_blank")
    },
    openLink2(index) { 
      window.open(this.courseLists[index].hash, "_blank")
    },
  },
};
</script>
<style>
  .search {
    display: flex;
    justify-content: space-between;
  }

  #search-input {
    width: 50%;
    background: #fff;
    font-size: 25px;
  }

.custom-file-input::-webkit-file-upload-button {
  visibility: hidden;
}
.custom-file-input::before {
  content: 'Select files';
  display: inline-block;
  background: -webkit-linear-gradient(top, #f9f9f9, #e3e3e3);
  border: 1px solid #999;
  border-radius: 3px;
  padding: 5px 8px;
  outline: none;
  white-space: nowrap;
  -webkit-user-select: none;
  cursor: pointer;
  text-shadow: 1px 1px #fff;
  font-weight: 700;
  font-size: 10pt;
}
.custom-file-input:hover::before {
  border-color: black;
}
.custom-file-input:active::before {
  background: -webkit-linear-gradient(top, #e3e3e3, #f9f9f9);
}
</style>
