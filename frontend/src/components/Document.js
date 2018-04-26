import React, { Component } from "react";
import PropTypes from "prop-types";
import Paragraph from "./Paragraph.js";
import VocabStore from "./VocabStore.js";

class Document extends Component {
  constructor(props) {
    super(props);
    this.updateItemStore = this.tempUpdateItemStore.bind(this);
    this.tempItemStore = {};
  }

  tempUpdateItemStore(key, value) {
    this.tempItemStore[key] = value;
  }
  finalUpdateItemStore(key, value) {
    let item = {};
    item[key] = value;
    this.itemStore.setState(item);
  }

  componentDidMount() {
    this.itemStore.setState(this.tempItemStore);
    this.updateItemStore = this.finalUpdateItemStore.bind(this);
  }

  render() {
    return (
      <div className="ca-document">
        <div className="ca-text">
          {this.props.paragraphs.map((p, i) => (
            <Paragraph
              segmentationGroups={p.segmentation_groups}
              key={i}
              id={"p" + i}
              updateItemStore={this.updateItemStore}
            />
          ))}
        </div>
        <VocabStore
          ref={instance => {
            this.itemStore = instance;
          }}
        />
      </div>
    );
  }
}

Document.propTypes = {
  paragraphs: PropTypes.shape({ segmentation_groups: PropTypes.array })
    .isRequired
};

export default Document;
