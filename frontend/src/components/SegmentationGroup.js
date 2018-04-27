import React, { Component } from "react";
import PropTypes from "prop-types";
import TextItem from "./TextItem.js";
import { DictionaryConsumer } from "./Dictionary.js";

class SegmentationGroup extends Component {
  constructor(props) {
    super(props);
    this.currentSegmentation = props.segmentations[0];
  }

  getEntries() {
    let entries = [];

    let l = this.currentSegmentation.length;
    for (var i = 0; i < l; i++) {
      entries.push(<TextItem value={this.currentSegmentation[i]} key={i} />);
    }

    return entries;
  }

  render() {
    if (this.props.inDictionary) {
      this.props.updateItemStore(this.props.id, this.currentSegmentation);
      return (
        <span className="ca-segment-group">
          <DictionaryConsumer>{this.getEntries()}</DictionaryConsumer>
        </span>
      );
    } else {
      return <span>{this.currentSegmentation.join()}</span>;
    }
  }
}

SegmentationGroup.propTypes = {
  inDictionary: PropTypes.bool,
  segmentations: PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.string))
    .isRequired,
  updateItemStore: PropTypes.func.isRequired
};

export default SegmentationGroup;
