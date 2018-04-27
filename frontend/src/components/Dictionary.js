import React, { Component } from "react";

const DictionaryContext = React.createContext();

class DictionaryProvider extends Component {
  state = { 你: "you", 好: "good" };

  componentDidMount() {
    this.setState({ "!": "!" });
  }

  render() {
    return (
      <DictionaryContext.Provider value={this.state}>
        {this.props.children}
      </DictionaryContext.Provider>
    );
  }
}

class DictionaryConsumer extends Component {
  render() {
    return (
      <DictionaryContext.Consumer>
        {dictionary => (
          <React.Fragment>
            {this.props.children.map(c =>
              React.cloneElement(c, { dictionary: dictionary })
            )}
          </React.Fragment>
        )}
      </DictionaryContext.Consumer>
    );
  }
}

export { DictionaryProvider, DictionaryConsumer };
